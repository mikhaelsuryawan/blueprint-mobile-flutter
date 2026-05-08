import 'dart:convert';

AuthTokenResponse authTokenResponseFromJson(String str) =>
    AuthTokenResponse.fromJson(json.decode(str));

String authTokenResponseToJson(AuthTokenResponse data) =>
    json.encode(data.toJson());

class AuthTokenResponse {
  AuthTokenResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  AuthTokenResponse.fromJson(dynamic json) {
    appName = json['app_name'];
    version = json['version'];
    build = json['build'];
    response = json['response'] != null
        ? AuthTokenReponseData.fromJson(json['response'])
        : null;
  }

  String? appName;
  String? version;
  String? build;
  AuthTokenReponseData? response;

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

AuthTokenReponseData responseFromJson(String str) =>
    AuthTokenReponseData.fromJson(json.decode(str));

String responseToJson(AuthTokenReponseData data) => json.encode(data.toJson());

class AuthTokenReponseData {
  AuthTokenReponseData({
    this.code,
    this.status,
    this.data,
    this.messageEn,
    this.messageId,
  });

  AuthTokenReponseData.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? AuthTokenData.fromJson(json['data']) : null;
    messageEn = json['message_en'];
    messageId = json['message_id'];
  }

  String? code;
  String? status;
  AuthTokenData? data;
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

AuthTokenData dataFromJson(String str) =>
    AuthTokenData.fromJson(json.decode(str));

String dataToJson(AuthTokenData data) => json.encode(data.toJson());

class AuthTokenData {
  AuthTokenData({
    this.name,
    this.deviceId,
    this.deviceType,
    this.token,
    this.tokenExpired,
    this.refreshToken,
    this.refreshTokenExpired,
    this.isLogin,
    this.userLogin,
  });

  AuthTokenData.fromJson(dynamic json) {
    name = json['name'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    token = json['token'];
    tokenExpired = json['token_expired'];
    refreshToken = json['refresh_token'];
    refreshTokenExpired = json['refresh_token_expired'];
    isLogin = json['is_login'];
    userLogin = json['user_login'];
  }

  String? name;
  String? deviceId;
  String? deviceType;
  String? token;
  String? tokenExpired;
  String? refreshToken;
  String? refreshTokenExpired;
  bool? isLogin;
  String? userLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['device_id'] = deviceId;
    map['device_type'] = deviceType;
    map['token'] = token;
    map['token_expired'] = tokenExpired;
    map['refresh_token'] = refreshToken;
    map['refresh_token_expired'] = refreshTokenExpired;
    map['is_login'] = isLogin;
    map['user_login'] = userLogin;
    return map;
  }
}
