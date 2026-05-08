import 'dart:convert';

ChangePasswordResponse changePasswordResponseFromJson(String str) =>
    ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordResponseToJson(ChangePasswordResponse data) =>
    json.encode(data.toJson());

class ChangePasswordResponse {
  ChangePasswordResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  ChangePasswordResponse.fromJson(dynamic json) {
    appName = json['app_name'];
    version = json['version'];
    build = json['build'];
    response = json['response'] != null
        ? ChangePasswordResponseData.fromJson(json['response'])
        : null;
  }

  String? appName;
  String? version;
  String? build;
  ChangePasswordResponseData? response;

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

ChangePasswordResponseData responseFromJson(String str) =>
    ChangePasswordResponseData.fromJson(json.decode(str));

String responseToJson(ChangePasswordResponseData data) =>
    json.encode(data.toJson());

class ChangePasswordResponseData {
  ChangePasswordResponseData({
    this.code,
    this.status,
    this.data,
    this.messageEn,
    this.messageId,
  });

  ChangePasswordResponseData.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null;
    messageEn = json['message_en'];
    messageId = json['message_id'];
  }

  String? code;
  String? status;
  dynamic data;
  String? messageEn;
  String? messageId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message_en'] = messageEn;
    map['message_id'] = messageId;
    return map;
  }
}
