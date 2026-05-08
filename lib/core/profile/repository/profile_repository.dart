import 'package:blueprint_mobile_flutter/constants/app_settings.dart';
import 'package:blueprint_mobile_flutter/core/profile/model/response/profile_response.dart';
import 'package:blueprint_mobile_flutter/utils/services/api/rest_api_service.dart';
import 'package:blueprint_mobile_flutter/utils/services/storage/local_storage_service.dart';
import 'package:dio/dio.dart';

abstract class ProfileRepository {
  Future<ProfileResponse> profile();
}

class ProfileService implements ProfileRepository {
  @override
  Future<ProfileResponse> profile() async {
    String param = "/authorization/authentication/profile";

    final Dio _client = await Client.initWithToken(
        baseUrl: AppSettings.apiBaseUrl,
        port: AppSettings.apiPort,
        isPort: AppSettings.isUsePort);

    Response response = await _client.get(
      param,
    );

    ProfileResponse data = profileResponseFromJson(response.toString());
    if (data.response!.data!.detailData != null)
      LocalStorageService.setProfile(data.response!.data!.detailData!);
    return data;
  }
}
