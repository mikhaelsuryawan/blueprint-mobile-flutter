import 'package:blueprint_mobile_flutter/constants/app_settings.dart';
import 'package:blueprint_mobile_flutter/core/logout/model/response/logout_response.dart';
import 'package:blueprint_mobile_flutter/utils/services/api/rest_api_service.dart';
import 'package:dio/dio.dart';

abstract class LogoutRepository {
  Future<LogoutResponse> logout();
}

class LogoutService implements LogoutRepository {
  @override
  Future<LogoutResponse> logout() async {
    String param = "/authorization/authentication/logout";

    final Dio _client = await Client.initWithToken(
        baseUrl: AppSettings.apiBaseUrl,
        port: AppSettings.apiPort,
        isPort: AppSettings.isUsePort);

    Response response = await _client.post(
      param,
    );

    LogoutResponse data = logoutResponseFromJson(response.toString());
    return data;
  }
}
