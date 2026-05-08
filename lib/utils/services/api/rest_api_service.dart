import 'dart:io';

import 'package:dio/dio.dart';

import '../../../config/routes/go_route_generator.dart';
import '../../../config/routes/routes.dart';
import '../../Helpers.dart';
import 'auth_interceptor.dart';
import 'dio_factory.dart';
import 'token_manager.dart';

/// HTTP client factory used by every repository in the app.
///
/// Three flavours:
///  - [init]                 – public / unauthenticated endpoints.
///  - [initWithToken]        – authenticated endpoints (auto-refresh on 401).
///  - [initWithRefreshToken] – the refresh-token endpoint itself.
///
/// Default-config instances are cached as singletons so the underlying
/// [HttpClient] (connection pool, TLS session cache) is reused across
/// requests.  Call [reset] to clear the cache (e.g. on logout).
class Client {
  Client._();

  static Dio? _plainDio;
  static Dio? _tokenDio;
  static Dio? _refreshDio;

  /// Clears cached [Dio] singletons. Call on logout or when the base-URL
  /// configuration changes at runtime.
  static void reset() {
    _plainDio = null;
    _tokenDio = null;
    _refreshDio = null;
  }

  // ------------------------------------------------------------------
  // Public factory methods (same signatures as before)
  // ------------------------------------------------------------------

  /// [Dio] **without** an auth token.
  /// Used for initial device-auth and other public endpoints.
  static Future<Dio> init({
    String baseUrl = '',
    String port = '',
    String isPort = '',
  }) async {
    final isDefault = baseUrl.isEmpty && port.isEmpty && isPort.isEmpty;
    if (isDefault && _plainDio != null) return _plainDio!;

    final dio = DioFactory.create(
      baseUrl: baseUrl,
      port: port,
      isPort: isPort,
    );

    // Resolve HTTP errors so callers always get a Response body.
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        if (error.response != null) return handler.resolve(error.response!);
        return handler.reject(error);
      },
    ));

    DioFactory.addDebugLogger(dio);

    if (isDefault) _plainDio = dio;
    return dio;
  }

  /// [Dio] **with** an auth token injected on every request.
  ///
  /// The token is read from secure storage at request-time so it is always
  /// up-to-date.  On 401 the [AuthInterceptor] transparently refreshes
  /// the token and retries the original request.
  static Future<Dio> initWithToken({
    String? tokenOtp,
    String? tokenReset,
    String baseUrl = '',
    String port = '',
    String isPort = '',
  }) async {
    final hasSpecialHeaders = tokenOtp != null || tokenReset != null;
    final isDefault = baseUrl.isEmpty && port.isEmpty && isPort.isEmpty;
    final canUseCached = isDefault && !hasSpecialHeaders;

    if (canUseCached && _tokenDio != null) return _tokenDio!;

    // Ensure we have *some* token before first use.
    String token = await TokenManager.getStoredToken();
    if (token.isEmpty) {
      token = await TokenManager.performTokenAuth();
    }

    final dio = DioFactory.create(
      baseUrl: baseUrl,
      port: port,
      isPort: isPort,
    );

    // 1. Inject auth headers dynamically on each request.
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final latestToken = await TokenManager.getStoredToken();
        options.headers['token'] = latestToken.isNotEmpty ? latestToken : token;
        if (tokenOtp != null) options.headers['otp-token'] = tokenOtp;
        if (tokenReset != null) {
          options.headers['reset-password-token'] = tokenReset;
        }
        handler.next(options);
      },
    ));

    // 2. Handle 401 with refresh + retry.
    dio.interceptors.add(AuthInterceptor());

    // 3. Logger last so it captures fully-prepared requests.
    DioFactory.addDebugLogger(dio);

    if (canUseCached) _tokenDio = dio;
    return dio;
  }

  /// [Dio] with the **refresh-token** header.
  /// Used exclusively to call the refresh-token endpoint.
  static Future<Dio> initWithRefreshToken({
    String baseUrl = '',
    String port = '',
    String isPort = '',
  }) async {
    final isDefault = baseUrl.isEmpty && port.isEmpty && isPort.isEmpty;
    if (isDefault && _refreshDio != null) return _refreshDio!;

    final dio = DioFactory.create(
      baseUrl: baseUrl,
      port: port,
      isPort: isPort,
    );

    // Inject refresh-token dynamically on each request.
    // If no refresh token: try device auth, then navigate to login if still missing.
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String refreshToken = await TokenManager.getStoredRefreshToken();
        final trimmed = refreshToken.trim();
        if (trimmed.isEmpty) {
          await TokenManager.performTokenAuth();
          refreshToken = await TokenManager.getStoredRefreshToken();
          if (refreshToken.trim().isEmpty) {
            _navigateToLogin();
            return handler.reject(
              DioException(
                requestOptions: options,
                error: 'No refresh token available; navigated to login',
              ),
            );
          }
        }
        options.headers['refresh-token'] = refreshToken;
        handler.next(options);
      },
    ));

    // On 401 / 500 from the refresh endpoint: attempt full device-auth.
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onError: (error, handler) async {
        final response = error.response;
        if (response == null) return handler.reject(error);

        final statusCode = response.statusCode;
        if (statusCode == 401 || statusCode == 500) {
          final newToken = await TokenManager.performTokenAuth();
          if (newToken.isEmpty) _navigateToLogin();
        }

        return handler.resolve(response);
      },
    ));

    DioFactory.addDebugLogger(dio);

    if (isDefault) _refreshDio = dio;
    return dio;
  }

  // ------------------------------------------------------------------
  // Internal helpers
  // ------------------------------------------------------------------

  static void _navigateToLogin() {
    try {
      final context = Helpers.navState.currentState?.context;
      if (context == null) return;
      // Use GoRouter to navigate and clear navigation stack
      appRouter.go(loginRoute);
    } catch (_) {}
  }
}
