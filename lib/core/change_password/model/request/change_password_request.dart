// To parse this JSON data, do
//
//     final changePasswordRequest = changePasswordRequestFromJson(jsonString);

import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) => ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) => json.encode(data.toJson());

class ChangePasswordRequest {
  ChangePasswordRequest({
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
  });

  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => ChangePasswordRequest(
    oldPassword: json["old_password"] == null ? "" : json["old_password"],
    newPassword: json["new_password"] == null ? "" : json["new_password"],
    confirmNewPassword: json["confirm_new_password"] == null ? "" : json["confirm_new_password"],
  );

  Map<String, dynamic> toJson() => {
    "old_password": oldPassword == null ? "" : oldPassword,
    "new_password": newPassword == null ? "" : newPassword,
    "confirm_new_password": confirmNewPassword == null ? "" : confirmNewPassword,
  };
}
