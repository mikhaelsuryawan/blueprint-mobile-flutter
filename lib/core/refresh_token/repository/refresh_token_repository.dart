import 'package:dio/dio.dart';

import '../../../constants/app_settings.dart';
import '../../../utils/services/api/rest_api_service.dart';
import '../../../utils/services/storage/secure_storage_service.dart';
import '../model/request/auth_token_request.dart';
import '../model/response/auth_token_response.dart';

abstract class RefreshTokenRepository {
  Future<AuthTokenResponse> refreshToken(AuthTokenRequest request);
}

class RefreshTokenService implements RefreshTokenRepository {
  @override
  Future<AuthTokenResponse> refreshToken(AuthTokenRequest request) async {
    const String param = "/authorization/token/refresh";

    final Dio client = await Client.initWithRefreshToken(
      baseUrl: AppSettings.apiBaseUrl,
      port: AppSettings.apiPort,
      isPort: AppSettings.isUsePort,
    );

    try {
      final Response response = await client.get(param);

      if (response.statusCode == 200) {
        final AuthTokenResponse data =
            authTokenResponseFromJson(response.toString());
        SecureStorageService.setApiToken(data.response?.data?.token ?? '');
        SecureStorageService.setRefreshApiToken(
            data.response?.data?.refreshToken ?? '');
        SecureStorageService.setDeviceId(data.response?.data?.deviceId ?? '');
        SecureStorageService.setLogin(data.response?.data?.isLogin ?? false);
        return data;
      }
      return _sessionExpiredResponse();
    } on DioException catch (e) {
      // 401/500 from refresh endpoint: interceptor may have run token/auth and
      // navigated; avoid crashing and return a failed response for the bloc.
      final statusCode = e.response?.statusCode;
      if (statusCode == 401 || statusCode == 500) {
        return _sessionExpiredResponse();
      }
      rethrow;
    }
  }

  static AuthTokenResponse _sessionExpiredResponse() {
    return AuthTokenResponse(
      response: AuthTokenReponseData(
        messageEn: 'Session expired. Please sign in again.',
      ),
    );
  }
}
