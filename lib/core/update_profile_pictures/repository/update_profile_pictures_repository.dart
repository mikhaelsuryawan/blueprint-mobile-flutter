import 'package:blueprint_mobile_flutter/constants/app_settings.dart';
import 'package:blueprint_mobile_flutter/core/update_profile_pictures/model/request/update_profile_picture_request.dart';
import 'package:blueprint_mobile_flutter/core/update_profile_pictures/model/response/update_profile_picture_response.dart';
import 'package:blueprint_mobile_flutter/utils/services/api/rest_api_service.dart';
import 'package:dio/dio.dart';

abstract class UpdateProfilePicturesRepository {
  Future<UpdateProfilePictureResponse> updateProfilePicture(
      UpdateProfilePictureRequest request);
}

class UpdateProfilePicturesService implements UpdateProfilePicturesRepository {
  @override
  Future<UpdateProfilePictureResponse> updateProfilePicture(
      UpdateProfilePictureRequest request) async {
    String param = "/hr-services/employee/profile-picture";

    final Dio _client = await Client.initWithToken(
        baseUrl: AppSettings.apiBaseUrl,
        port: AppSettings.apiPort,
        isPort: AppSettings.isUsePort);

    Response response = await _client.put(
      param,
      data: updateProfilePictureRequestToJson(request),
    );

    UpdateProfilePictureResponse data =
        updateProfilePictureResponseFromJson(response.toString());
    return data;
  }
}
