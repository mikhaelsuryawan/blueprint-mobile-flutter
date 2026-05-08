import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:platform_device_id_plus/platform_device_id.dart';
import '../../../constants/app_settings.dart';
import '../../../core/refresh_token/model/request/auth_token_request.dart';
import '../../../core/refresh_token/model/response/auth_token_response.dart';
import '../../Helpers.dart';
import '../../../utils/services/api/dio_factory.dart';
import '../storage/secure_storage_service.dart';

/// Centralises every token-related operation:
/// building auth requests, calling auth / refresh endpoints,
/// persisting tokens, and reading stored tokens.
class TokenManager {
  TokenManager._();

  // ------------------------------------------------------------------
  // Stored-token accessors
  // ------------------------------------------------------------------

  static Future<String> getStoredToken() async {
    try {
      final value = await SecureStorageService.getApiToken();
      return value?.toString() ?? '';
    } catch (_) {
      return '';
    }
  }

  static Future<String> getStoredRefreshToken() async {
    try {
      final value = await SecureStorageService.getRefreshApiToken();
      return value?.toString() ?? '';
    } catch (_) {
      return '';
    }
  }

  // ------------------------------------------------------------------
  // Auth-request builder
  // ------------------------------------------------------------------

  static Future<AuthTokenRequest> buildAuthRequest() async {
    final request = AuthTokenRequest()
      ..fcmToken = await _getFcmTokenSafe()
      ..appKey = AppSettings.authAppKey
      ..appName = AppSettings.authAppName
      ..deviceType = Platform.isIOS ? 'mobile-ios' : 'mobile-android';

    try {
      request.deviceId = await PlatformDeviceId.getDeviceId;
    } catch (_) {
      request.deviceId = '';
    }

    try {
      request.ipAddress = await Helpers.getIpAddress();
    } catch (_) {}

    return request;
  }

  // ------------------------------------------------------------------
  // Token endpoints
  // ------------------------------------------------------------------

  /// POST `/authorization/token/auth` (device-level auth, no user token
  /// required). Returns the new token string, or empty on failure.
  ///
  /// When [requireLogin] is `true` the call is considered failed if the
  /// server responds with `isLogin == false` (the user's session expired).
  static Future<String> performTokenAuth({
    bool requireLogin = false,
  }) async {
    try {
      final dio = DioFactory.create();
      final request = await buildAuthRequest();
      final response = await dio.post(
        '/authorization/token/auth',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
        data: authTokenRequestToJson(request),
      );

      if (response.statusCode != 200) return '';

      final data = authTokenResponseFromJson(response.toString());
      await _persistTokenData(data);

      final isLogin = data.response?.data?.isLogin ?? false;
      if (requireLogin && !isLogin) return '';

      return data.response?.data?.token ?? '';
    } catch (e) {
      Helpers.log('TokenManager', 'performTokenAuth error: $e');
      return '';
    }
  }

  /// GET `/authorization/token/refresh` using the stored refresh-token.
  /// Returns the new access-token, or empty on failure / when the user
  /// is no longer logged in.
  static Future<String> refreshToken() async {
    try {
      final dio = DioFactory.create();
      final storedRefresh = await getStoredRefreshToken();
      dio.options.headers['refresh-token'] = storedRefresh;

      final response = await dio.get(
        '/authorization/token/refresh',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode != 200) return '';

      final data = authTokenResponseFromJson(response.toString());
      await _persistTokenData(data);

      if (!(data.response?.data?.isLogin ?? false)) return '';

      return data.response?.data?.token ?? '';
    } catch (e) {
      Helpers.log('TokenManager', 'refreshToken error: $e');
      return '';
    }
  }

  // ------------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------------

  static Future<void> _persistTokenData(AuthTokenResponse data) async {
    final tokenData = data.response?.data;
    if (tokenData == null) return;

    SecureStorageService.setApiToken(tokenData.token ?? '');
    SecureStorageService.setRefreshApiToken(tokenData.refreshToken ?? '');
    SecureStorageService.setDeviceId(tokenData.deviceId ?? '');
    SecureStorageService.setLogin(tokenData.isLogin ?? false);
  }

  static Future<String?> _getFcmTokenSafe() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) return token;
    } catch (e) {
      Helpers.log('FCM', 'Unavailable: $e');
    }
    return null;
  }
}
