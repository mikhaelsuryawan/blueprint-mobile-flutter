import 'package:dio/dio.dart';

import '../../../constants/app_settings.dart';
import '../../../utils/services/api/rest_api_service.dart';
import '../../../utils/services/storage/secure_storage_service.dart';
import '../../refresh_token/model/request/auth_token_request.dart';
import '../../refresh_token/model/response/auth_token_response.dart';

abstract class AuthTokenRepository {
  Future<AuthTokenResponse> authToken(AuthTokenRequest request);
}

class AuthTokenService implements AuthTokenRepository {
  @override
  Future<AuthTokenResponse> authToken(AuthTokenRequest request) async {
    String param = "/authorization/token/auth";

    final Dio _client = await Client.init(
        baseUrl: AppSettings.apiBaseUrl,
        port: AppSettings.apiPort,
        isPort: AppSettings.isUsePort);

    try {
      Response response = await _client.post(
        param,
        data: authTokenRequestToJson(request),
      );

      final AuthTokenResponse data = _parseAuthTokenResponse(response);

      if (response.statusCode == 200 && data.response?.data != null) {
        SecureStorageService.setApiToken(data.response?.data?.token ?? "");
        SecureStorageService.setRefreshApiToken(
            data.response?.data?.refreshToken ?? "");
        // SecureStorageService.setFcmToken(data.response?.data?.fcmToken ?? "");
        SecureStorageService.setDeviceId(data.response?.data?.deviceId ?? "");
        SecureStorageService.setLogin(data.response?.data?.isLogin ?? false);
      }

      return data;
    } catch (_) {
      return AuthTokenResponse();
    }
  }

  /// Parses response body into [AuthTokenResponse] for both 200 and error
  AuthTokenResponse _parseAuthTokenResponse(Response response) {
    try {
      final raw = response.data;
      if (raw is Map<String, dynamic>) {
        return AuthTokenResponse.fromJson(raw);
      }
      if (raw is String) {
        return authTokenResponseFromJson(raw);
      }
      return AuthTokenResponse();
    } catch (_) {}
    return AuthTokenResponse();
  }
}
