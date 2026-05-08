import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) =>
    LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  LogoutResponse.fromJson(dynamic json) {
    appName = json['app_name'];
    version = json['version'];
    build = json['build'];
    response = json['response'] != null
        ? LogoutResponseData.fromJson(json['response'])
        : null;
  }

  String? appName;
  String? version;
  String? build;
  LogoutResponseData? response;

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

LogoutResponseData responseFromJson(String str) =>
    LogoutResponseData.fromJson(json.decode(str));

String responseToJson(LogoutResponseData data) => json.encode(data.toJson());

class LogoutResponseData {
  LogoutResponseData({
    this.code,
    this.status,
    this.data,
    this.messageEn,
    this.messageId,
  });

  LogoutResponseData.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'];
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
    map['data'] = data;
    map['message_en'] = messageEn;
    map['message_id'] = messageId;
    return map;
  }
}
