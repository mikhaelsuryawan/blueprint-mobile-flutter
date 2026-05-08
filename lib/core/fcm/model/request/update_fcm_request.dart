// To parse this JSON data, do
//
//     final updateFcmRequest = updateFcmRequestFromJson(jsonString);

import 'dart:convert';

UpdateFcmRequest updateFcmRequestFromJson(String str) =>
    UpdateFcmRequest.fromJson(json.decode(str));

String updateFcmRequestToJson(UpdateFcmRequest data) =>
    json.encode(data.toJson());

class UpdateFcmRequest {
  UpdateFcmRequest({
    this.fcmToken,
  });

  String? fcmToken;

  factory UpdateFcmRequest.fromJson(Map<String, dynamic> json) =>
      UpdateFcmRequest(
        fcmToken: json["fcm_token"] == null ? "" : json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "fcm_token": fcmToken == null ? "" : fcmToken,
      };
}
