import 'package:dio/dio.dart';

import '../../../constants/app_settings.dart';
import '../../../utils/services/storage/local_storage_service.dart';
import '../../../utils/services/api/rest_api_service.dart';
import '../model/request/login_request.dart';
import '../model/response/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginService implements LoginRepository {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    String param = "/authorization/authentication/login";

    try {
      final Dio _client = await Client.initWithToken(
          baseUrl: AppSettings.apiBaseUrl,
          port: AppSettings.apiPort,
          isPort: AppSettings.isUsePort);

      Response response = await _client.post(
        param,
        data: loginRequestToJson(request),
      );

      if (response.statusCode == 200) {
        LoginResponse data = loginResponseFromJson(response.toString());
        if (data.response != null) {
          if (data.response!.data != null) {
            LocalStorageService.setLogin(data.response!.data!);
          }
        }
        return data;
      } else {
        return LoginResponse();
      }
    } catch (_) {
      return LoginResponse();
    }
  }
}
