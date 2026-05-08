import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) =>
    SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  SignUpRequest({
    this.name,
    this.birthDate,
    this.gender,
    this.email,
    this.phoneNumber,
    this.password,
    this.confirmationPassword,
  });

  String? name;
  String? birthDate; // dd-MM-yyyy e.g. 27-01-2000
  String? gender; // Male or Female
  String? email;
  String? phoneNumber; // e.g. +62812110022
  String? password;
  String? confirmationPassword;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        name: json["name"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        confirmationPassword: json["confirmation_password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name ?? "",
        "birth_date": birthDate ?? "",
        "gender": gender ?? "",
        "email": email ?? "",
        "phone_number": _normalizePhoneNumber(phoneNumber ?? ""),
        "password": password ?? "",
        "confirmation_password": confirmationPassword ?? "",
      };

  /// Normalize phone to +62 format for API (e.g. 0812110022 -> +62812110022)
  static String _normalizePhoneNumber(String phone) {
    final trimmed = phone.trim().replaceAll(RegExp(r'\s'), '');
    if (trimmed.isEmpty) return trimmed;
    if (trimmed.startsWith('+62')) return trimmed;
    if (trimmed.startsWith('62')) return '+$trimmed';
    if (trimmed.startsWith('0')) return '+62${trimmed.substring(1)}';
    return '+62$trimmed';
  }
}
