import 'dart:convert';

UpdateProfilePictureRequest updateProfilePictureRequestFromJson(String str) =>
    UpdateProfilePictureRequest.fromJson(json.decode(str));

String updateProfilePictureRequestToJson(UpdateProfilePictureRequest data) =>
    json.encode(data.toJson());

class UpdateProfilePictureRequest {
  UpdateProfilePictureRequest({
    this.urlProfilePicture,
  });

  UpdateProfilePictureRequest.fromJson(dynamic json) {
    urlProfilePicture = json['url_profile_picture'];
  }

  String? urlProfilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url_profile_picture'] = urlProfilePicture;
    return map;
  }
}
