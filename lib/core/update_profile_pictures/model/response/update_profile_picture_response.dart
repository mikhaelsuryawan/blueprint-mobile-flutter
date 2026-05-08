import 'dart:convert';

UpdateProfilePictureResponse updateProfilePictureResponseFromJson(String str) =>
    UpdateProfilePictureResponse.fromJson(json.decode(str));

String updateProfilePictureResponseToJson(UpdateProfilePictureResponse data) =>
    json.encode(data.toJson());

class UpdateProfilePictureResponse {
  UpdateProfilePictureResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  UpdateProfilePictureResponse.fromJson(dynamic json) {
    appName = json['app_name'];
    version = json['version'];
    build = json['build'];
    response = json['response'] != null
        ? UpdateProfilePictureResponseData.fromJson(json['response'])
        : null;
  }

  String? appName;
  String? version;
  String? build;
  UpdateProfilePictureResponseData? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['app_name'] = appName;
    map['version'] = version;
    map['build'] = build;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }
}

UpdateProfilePictureResponseData responseFromJson(String str) =>
    UpdateProfilePictureResponseData.fromJson(json.decode(str));

String responseToJson(UpdateProfilePictureResponseData data) =>
    json.encode(data.toJson());

class UpdateProfilePictureResponseData {
  UpdateProfilePictureResponseData({
    this.code,
    this.status,
    this.messageEn,
    this.messageId,
  });

  UpdateProfilePictureResponseData.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    messageEn = json['message_en'];
    messageId = json['message_id'];
  }

  String? code;
  String? status;
  String? messageEn;
  String? messageId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    map['message_en'] = messageEn;
    map['message_id'] = messageId;
    return map;
  }
}
