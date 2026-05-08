import 'dart:convert';

UpdateFcmResponse updateFcmResponseFromJson(String str) =>
    UpdateFcmResponse.fromJson(json.decode(str));

String updateFcmResponseToJson(UpdateFcmResponse data) =>
    json.encode(data.toJson());

class UpdateFcmResponse {
  UpdateFcmResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  UpdateFcmResponse.fromJson(dynamic json) {
    appName = json['app_name'];
    version = json['version'];
    build = json['build'];
    response = json['response'] != null
        ? UpdateFcmResponseData.fromJson(json['response'])
        : null;
  }

  String? appName;
  String? version;
  String? build;
  UpdateFcmResponseData? response;

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

UpdateFcmResponseData responseFromJson(String str) =>
    UpdateFcmResponseData.fromJson(json.decode(str));

String responseToJson(UpdateFcmResponseData data) => json.encode(data.toJson());

class UpdateFcmResponseData {
  UpdateFcmResponseData({
    this.code,
    this.status,
    this.messageEn,
    this.messageId,
  });

  UpdateFcmResponseData.fromJson(dynamic json) {
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
