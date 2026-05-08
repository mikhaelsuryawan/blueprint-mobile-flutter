import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/app_settings.dart';
import '../../../utils/services/api/rest_api_service.dart';
import '../model/request/sign_up_request.dart';
import '../model/response/sign_up_response.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> signUp(SignUpRequest request);
}

class SignUpService implements SignUpRepository {
  @override
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    const String param = "/authorization/authentication/register";

    final Dio _client = await Client.initWithToken(
        baseUrl: AppSettings.apiBaseUrl,
        port: AppSettings.apiPort,
        isPort: AppSettings.isUsePort);

    Response response = await _client.post(
      param,
      data: signUpRequestToJson(request),
    );

    final body = response.data;
    final jsonStr = body is String ? body : json.encode(body);
    return signUpResponseFromJson(jsonStr);
  }
}
