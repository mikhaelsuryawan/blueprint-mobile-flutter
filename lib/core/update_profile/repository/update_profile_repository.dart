import 'package:blueprint_mobile_flutter/constants/app_settings.dart';
import 'package:blueprint_mobile_flutter/core/profile/model/response/profile_response.dart';
import 'package:blueprint_mobile_flutter/core/update_profile/model/request/update_profile_request.dart';
import 'package:blueprint_mobile_flutter/core/update_profile/model/response/update_profile_response.dart';
import 'package:blueprint_mobile_flutter/utils/services/api/rest_api_service.dart';
import 'package:blueprint_mobile_flutter/utils/services/storage/local_storage_service.dart';
import 'package:dio/dio.dart';

abstract class UpdateProfileRepository {
  Future<UpdateProfileResponse> updateProfile(UpdateProfileRequest request);
}

class UpdateProfileService implements UpdateProfileRepository {
  @override
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest request) async {
    String param = "/hr-services/employee/" + request.guid!;

    final Dio _client = await Client.initWithToken(
        baseUrl: AppSettings.apiBaseUrl,
        port: AppSettings.apiPort,
        isPort: AppSettings.isUsePort);

    Response response = await _client.put(
      param,
      data: updateProfileRequestToJson(request),
    );

    UpdateProfileResponse data =
        updateProfileResponseFromJson(response.toString());
    print(detailDataFromJson(updateProfileDataToJson(data.response!.data!))
        .toJson());
    if (data.response!.data != null)
      LocalStorageService.setProfile(
          detailDataFromJson(updateProfileDataToJson(data.response!.data!)));
    return data;
  }
}
