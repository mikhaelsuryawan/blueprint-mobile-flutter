import 'dart:convert';

AuthTokenRequest authTokenRequestFromJson(String str) =>
    AuthTokenRequest.fromJson(json.decode(str));

String authTokenRequestToJson(AuthTokenRequest data) =>
    json.encode(data.toJson());

class AuthTokenRequest {
  AuthTokenRequest({
    this.appName,
    this.appKey,
    this.deviceId,
    this.deviceType,
    this.fcmToken,
    this.ipAddress,
  });

  AuthTokenRequest.fromJson(dynamic json) {
    appName = json['app_name'];
    appKey = json['app_key'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
    ipAddress = json['ip_address'];
  }

  String? appName;
  String? appKey;
  String? deviceId;
  String? deviceType;
  String? fcmToken;
  String? ipAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['app_name'] = appName;
    map['app_key'] = appKey;
    map['device_id'] = deviceId;
    map['device_type'] = deviceType;
    map['fcm_token'] = fcmToken;
    map['ip_address'] = ipAddress;
    return map;
  }
}
