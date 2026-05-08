import 'package:blueprint_mobile_flutter/constants/app_settings.dart';
import 'package:blueprint_mobile_flutter/core/fcm/model/request/update_fcm_request.dart';
import 'package:blueprint_mobile_flutter/core/fcm/model/response/update_fcm_response.dart';
import 'package:blueprint_mobile_flutter/utils/services/api/rest_api_service.dart';
import 'package:dio/dio.dart';

abstract class FcmRepository {
  Future<UpdateFcmResponse> updateFcm(UpdateFcmRequest request);
}

class FcmService implements FcmRepository {
  @override
  Future<UpdateFcmResponse> updateFcm(UpdateFcmRequest request) async {
    String param = "/authorization/authentication/update-fcm-token";

    final Dio _client = await Client.initWithToken(
        baseUrl: AppSettings.apiBaseUrl,
        port: AppSettings.apiPort,
        isPort: AppSettings.isUsePort);

    Response response = await _client.put(
      param,
      data: updateFcmRequestToJson(request),
    );

    UpdateFcmResponse data = updateFcmResponseFromJson(response.toString());
    return data;
  }
}
