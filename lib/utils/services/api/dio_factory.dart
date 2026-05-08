import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../constants/app_settings.dart';

/// Creates pre-configured [Dio] instances with shared SSL bypass,
/// JSON headers, timeouts, and an optional debug logger.
///
/// Every [Dio] produced by [create] is independent (its own connection pool),
/// so callers that need connection reuse should cache the instance.
class DioFactory {
  DioFactory._();

  static String resolveBaseUrl({
    String baseUrl = '',
    String port = '',
    String isPort = '',
  }) {
    if (baseUrl.isEmpty) baseUrl = AppSettings.apiBaseUrl;
    if (port.isEmpty) port = AppSettings.apiPort;
    if (isPort.isEmpty) isPort = AppSettings.isUsePort;
    return isPort == '1' ? '$baseUrl:$port' : baseUrl;
  }

  /// Builds a [Dio] with standard options. The caller is responsible for
  /// adding interceptors (token injection, error handling, etc.).
  static Dio create({
    String baseUrl = '',
    String port = '',
    String isPort = '',
  }) {
    final dio = Dio();

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (_, __, ___) => true;
        return client;
      },
    );

    dio.options
      ..baseUrl = resolveBaseUrl(baseUrl: baseUrl, port: port, isPort: isPort)
      ..headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      })
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);

    return dio;
  }

  /// Appends [PrettyDioLogger] and a non-2xx logger to [dio] in debug builds only.
  /// Call this *after* all other interceptors so logged requests contain
  /// every header (e.g. dynamically-injected tokens).
  /// Non-2xx responses are always logged (status + body) so error payloads are visible.
  static void addDebugLogger(Dio dio) {
    if (!kDebugMode) return;

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        _logNon2xx(response.statusCode, response.data);
        handler.next(response);
      },
      onError: (error, handler) {
        if (error.response != null) {
          _logNon2xx(
            error.response!.statusCode,
            error.response!.data,
            label: 'Error response',
          );
        }
        handler.next(error);
      },
    ));
  }

  static void _logNon2xx(int? statusCode, dynamic body,
      {String label = 'Response'}) {
    if (statusCode == null || statusCode < 300) return;
    final bodyStr = body is Map
        ? const JsonEncoder.withIndent('  ').convert(body)
        : body?.toString() ?? '';
    // Use print so it always appears (debugPrint can be throttled/dropped).
    print('╔══ $label [$statusCode] ══╗');
    print(bodyStr);
    print('╚══════════════════════════════╝');
  }

  /// Call this from interceptors that resolve with a non-2xx response so the
  /// payload is always logged (e.g. AuthInterceptor resolving 401 for login).
  static void logResponseIfNon2xx(Response response,
      {String label = 'Response'}) {
    if (!kDebugMode) return;
    _logNon2xx(response.statusCode, response.data, label: label);
  }
}
