import 'dart:convert';

ErrorMessageResponse errorResponseFromJson(String str) =>
    ErrorMessageResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorMessageResponse data) =>
    json.encode(data.toJson());

class ErrorMessageResponse {
  ErrorMessageResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  ErrorMessageResponse.fromJson(dynamic json) {
    appName = json['app_name'];
    version = json['version'];
    build = json['build'];
    final rawResponse = json['response'];
    if (rawResponse == null) {
      response = null;
    } else if (rawResponse is Map<String, dynamic>) {
      response = ErrorMessageResponseData.fromJson(rawResponse);
    } else if (rawResponse is String) {
      response = ErrorMessageResponseData(messageEn: rawResponse);
    } else {
      response = null;
    }
  }

  String? appName;
  String? version;
  String? build;
  ErrorMessageResponseData? response;

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

ErrorMessageResponseData responseFromJson(String str) =>
    ErrorMessageResponseData.fromJson(json.decode(str));

String responseToJson(ErrorMessageResponseData data) =>
    json.encode(data.toJson());

class ErrorMessageResponseData {
  ErrorMessageResponseData({
    this.code,
    this.status,
    this.data,
    this.messageEn,
    this.messageId,
  });

  ErrorMessageResponseData.fromJson(dynamic json) {
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
