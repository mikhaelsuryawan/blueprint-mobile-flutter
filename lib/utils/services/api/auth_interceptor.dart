import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/models/error/response/error_message_response.dart'
    show ErrorMessageResponse, ErrorMessageResponseData;
import '../../../config/routes/go_route_generator.dart';
import '../../../config/routes/routes.dart';
import '../../../core/models/error/response/error_message_response.dart';
import '../../Helpers.dart';
import 'dio_factory.dart';
import 'token_manager.dart';

/// Queued interceptor for the authenticated [Dio] that handles 401 responses.
///
/// Flow on 401:
///  1. `"Please login first"`  -> toast + navigate to login.
///  2. Recoverable token errors (e.g. `"Unauthorized token"`, code `41`,
///     `"Header token not found"`) -> refresh token, retry; then device-auth
///     with [requireLogin] true, then false (covers login before session exists).
///  3. Any other 401 message   -> resolve with the error response.
///
/// Non-401 errors are resolved so callers always receive a [Response].
/// Network-level errors (no response) are rejected.
///
/// Retries use a **separate** [Dio] (via [DioFactory]) to avoid deadlocking
/// the queued interceptor.
class AuthInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    final response = error.response;

    if (response == null) {
      return handler.reject(error);
    }

    if (response.statusCode != 401) {
      DioFactory.logResponseIfNon2xx(response,
          label: "${response.statusCode} ${response.statusMessage}");
      return handler.resolve(response);
    }

    try {
      final errorData = _parseErrorData(response);
      final messageEn = errorData?.messageEn?.toLowerCase() ?? '';

      if (messageEn == 'please login first') {
        DioFactory.logResponseIfNon2xx(response,
            label: "${response.statusCode} ${response.statusMessage}");
        _showToast(messageEn);
        _navigateToLogin();
        return handler.resolve(response);
      }

      if (_isRecoverableToken401(errorData)) {
        return await _handleTokenRecovery(error, handler);
      }
    } catch (_) {
      // Swallow parsing / recovery errors – resolve with original response.
    }

    DioFactory.logResponseIfNon2xx(response,
        label: "${response.statusCode} ${response.statusMessage}");
    return handler.resolve(response);
  }

  // ----------------------------------------------------------------
  // 401 token recovery (refresh + device auth + retry)
  // ----------------------------------------------------------------

  /// True when the server indicates a missing/expired token rather than
  /// business-rule auth failure (e.g. wrong password).
  bool _isRecoverableToken401(ErrorMessageResponseData? data) {
    if (data == null) return false;
    final messageEn = (data.messageEn ?? '').toLowerCase();
    final messageId = (data.messageId ?? '').toLowerCase();

    if (messageEn == 'unauthorized token') return true;
    if (data.code == '41') return true;

    final mentionsTokenIssue = messageEn.contains('token') &&
        (messageEn.contains('not found') ||
            messageEn.contains('tidak ditemukan') ||
            (messageEn.contains('header') && messageEn.contains('token')));
    if (mentionsTokenIssue) return true;

    if (messageId.contains('token') && messageId.contains('tidak ditemukan')) {
      return true;
    }

    return false;
  }

  Future<void> _handleTokenRecovery(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final originalOptions = error.response!.requestOptions;

    // Step 1: JWT refresh when a refresh token exists.
    final refreshedToken = await TokenManager.refreshToken();
    if (refreshedToken.isNotEmpty) {
      final result = await _retryRequest(originalOptions, refreshedToken);
      if (result != null) return handler.resolve(result);
    }

    // Step 2: Full device-auth expecting an existing user session.
    var authToken = await TokenManager.performTokenAuth(requireLogin: true);
    if (authToken.isNotEmpty) {
      final result = await _retryRequest(originalOptions, authToken);
      if (result != null) return handler.resolve(result);
    }

    // Step 3: Device token only (e.g. login before `isLogin`, or empty stored token).
    authToken = await TokenManager.performTokenAuth(requireLogin: false);
    if (authToken.isNotEmpty) {
      final result = await _retryRequest(originalOptions, authToken);
      if (result != null) return handler.resolve(result);
    }

    DioFactory.logResponseIfNon2xx(error.response!,
        label: '401 Recovery exhausted');
    _navigateToLogin();
    return handler.resolve(error.response!);
  }

  /// Retries the original request with [newToken] using a clean [Dio]
  /// (no auth interceptor) to avoid deadlocking the queued interceptor.
  Future<Response?> _retryRequest(
    RequestOptions original,
    String newToken,
  ) async {
    try {
      final retryDio = DioFactory.create();
      final headers = Map<String, dynamic>.from(original.headers);
      headers['token'] = newToken;
      final opts = original.copyWith(headers: headers);
      return await retryDio.fetch(opts);
    } catch (e) {
      if (e is DioException && e.response != null) return e.response;
      return null;
    }
  }

  // ----------------------------------------------------------------
  // Helpers
  // ----------------------------------------------------------------

  ErrorMessageResponseData? _parseErrorData(Response response) {
    final rawData = response.data;
    if (rawData is! Map<String, dynamic>) return null;
    try {
      return ErrorMessageResponse.fromJson(rawData).response;
    } catch (_) {
      return null;
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  void _navigateToLogin() {
    try {
      final context = Helpers.navState.currentState?.context;
      if (context == null) return;
      appRouter.go(loginRoute);
    } catch (_) {}
  }
}
