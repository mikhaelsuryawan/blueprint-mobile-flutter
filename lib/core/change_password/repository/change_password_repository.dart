import 'package:dio/dio.dart';

import '../../../constants/app_settings.dart';
import '../../../utils/services/api/rest_api_service.dart';
import '../model/request/change_password_request.dart';
import '../model/response/change_password_response.dart';

abstract class ChangePasswordRepository {
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request);
}

class ChangePasswordService implements ChangePasswordRepository {
  @override
  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest request) async {
    String param = '/authorization/authentication/change-password';

    final Dio _client = await Client.initWithToken(
        baseUrl: AppSettings.apiBaseUrl,
        port: AppSettings.apiPort,
        isPort: AppSettings.isUsePort);

    Response response = await _client.post(
      param,
      data: changePasswordRequestToJson(request),
    );

    if (response.statusCode == 200) {
      ChangePasswordResponse data =
          changePasswordResponseFromJson(response.toString());
      return data;
    } else {
      return ChangePasswordResponse();
    }
  }
}
