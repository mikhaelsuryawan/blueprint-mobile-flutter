import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  String? appName;
  String? version;
  String? build;
  SignUpResponseData? response;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        appName: json["app_name"],
        version: json["version"],
        build: json["build"],
        response: json["response"] == null
            ? null
            : SignUpResponseData.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "app_name": appName,
        "version": version,
        "build": build,
        "response": response?.toJson(),
      };
}

class SignUpResponseData {
  SignUpResponseData({
    this.code,
    this.status,
    this.data,
    this.messageEn,
    this.messageId,
  });

  String? code;
  String? status;
  dynamic data;
  String? messageEn;
  String? messageId;

  factory SignUpResponseData.fromJson(Map<String, dynamic> json) =>
      SignUpResponseData(
        code: json["code"],
        status: json["status"],
        data: json["data"],
        messageEn: json["message_en"],
        messageId: json["message_id"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data,
        "message_en": messageEn,
        "message_id": messageId,
      };
}
