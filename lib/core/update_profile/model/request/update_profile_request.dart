// To parse this JSON data, do
//
//     final updateProfileRequest = updateProfileRequestFromJson(jsonString);

import 'dart:convert';

import '../../../../utils/Helpers.dart';
import '../../../profile/model/response/profile_response.dart';

UpdateProfileRequest updateProfileRequestFromJson(String str) =>
    UpdateProfileRequest.fromJson(json.decode(str));

UpdateProfileRequest updateProfileRequestFromProfileJson(String str) =>
    UpdateProfileRequest.fromProfileJson(json.decode(str));

String updateProfileRequestToJson(UpdateProfileRequest data) =>
    json.encode(data.toJson());

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.guid,
    this.fullname,
    this.nickname,
    this.dateOfBirth,
    this.gender,
    this.addressIdCard,
    this.addressDomicile,
    this.maritalStatus,
    this.education,
    this.email,
    this.phoneNumber,
    this.idCard,
    this.npwp,
    this.joinDate,
    this.nik,
    this.bankName,
    this.bankAccount,
    this.insuranceNumber,
    this.insuranceInstitution,
    this.bpjsKetenagakerjaan,
    this.urlProfilePicture,
    this.aboutMe,
    this.skills,
    this.interests,
    this.expertise,
    this.cvFileUrl,
    this.urlSocialMedia,
    this.jobId,
    this.jobName,
    this.departmentId,
    this.departmentName,
    this.outletId,
    this.outletName,
    this.subBrandId,
    this.subBrandName,
    this.brandId,
    this.brandName,
  });

  String? guid;
  String? fullname;
  String? nickname;
  DateTime? dateOfBirth;
  String? gender;
  String? addressIdCard;
  String? addressDomicile;
  String? maritalStatus;
  String? education;
  String? email;
  String? phoneNumber;
  String? idCard;
  String? npwp;
  DateTime? joinDate;
  String? nik;
  String? bankName;
  String? bankAccount;
  String? insuranceNumber;
  String? insuranceInstitution;
  String? bpjsKetenagakerjaan;
  String? urlProfilePicture;
  String? aboutMe;
  List<String>? skills;
  String? interests;
  String? expertise;
  String? cvFileUrl;
  List<dynamic>? urlSocialMedia;
  String? jobId;
  String? jobName;
  String? departmentId;
  String? departmentName;
  String? outletId;
  String? outletName;
  String? subBrandId;
  String? subBrandName;
  String? brandId;
  String? brandName;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        guid: json["guid"],
        fullname: json["fullname"],
        nickname: json["nickname"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        addressIdCard: json["address_id_card"],
        addressDomicile: json["address_domicile"],
        maritalStatus: json["marital_status"],
        education: json["education"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        idCard: json["id_card"],
        npwp: json["npwp"],
        joinDate: json["join_date"] == null
            ? null
            : DateTime.parse(json["join_date"]),
        nik: json["nik"],
        bankName: json["bank_name"],
        bankAccount: json["bank_account"],
        insuranceNumber: json["insurance_number"],
        insuranceInstitution: json["insurance_institution"],
        bpjsKetenagakerjaan: json["bpjs_ketenagakerjaan"],
        urlProfilePicture: json["url_profile_picture"],
        aboutMe: json["about_me"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        interests: json["interests"],
        expertise: json["expertise"],
        cvFileUrl: json["cv_file_url"],
        urlSocialMedia: json["url_social_media"] == null
            ? []
            : List<dynamic>.from(json["url_social_media"]!.map((x) => x)),
        jobId: json["job_id"],
        jobName: json["job_name"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
        outletId: json["outlet_id"],
        outletName: json["outlet_name"],
        subBrandId: json["sub_brand_id"],
        subBrandName: json["sub_brand_name"],
        brandId: json["brand_id"],
        brandName: json["brand_name"],
      );

  factory UpdateProfileRequest.fromProfileJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        guid: json["guid"],
        fullname: json["fullname"],
        nickname: json["nickname"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        addressIdCard: json["address_id_card"],
        addressDomicile: json["address_domicile"],
        maritalStatus: json["marital_status"],
        education: json["education"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        idCard: json["id_card"],
        npwp: json["npwp"],
        bankName: json["bank_name"],
        bankAccount: json["bank_account"],
        insuranceNumber: json["insurance_number"],
        insuranceInstitution: json["insurance_institution"],
        bpjsKetenagakerjaan: json["bpjs_ketenagakerjaan"],
        urlProfilePicture: json["url_profile_picture"],
        aboutMe: json["about_me"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        interests: json["interests"],
        expertise: json["expertise"],
        cvFileUrl: json["cv_file_url"],
        urlSocialMedia: json["url_social_media"] == null
            ? []
            : List<dynamic>.from(json["url_social_media"]!.map((x) => x)),
        jobId:
            json["job"] == null ? null : Brand.fromJson(json["job"]).guid ?? '',
        jobName:
            json["job"] == null ? null : Brand.fromJson(json["job"]).name ?? '',
        outletId: json["outlet"] == null
            ? null
            : Brand.fromJson(json["outlet"]).guid ?? '',
        outletName: json["outlet"] == null
            ? null
            : Brand.fromJson(json["outlet"]).name ?? '',
        brandId: json["brand"] == null
            ? null
            : Brand.fromJson(json["brand"]).guid ?? '',
        brandName: json["brand"] == null
            ? null
            : Brand.fromJson(json["brand"]).name ?? '',
        subBrandId: json["subbrand"] == null
            ? null
            : Brand.fromJson(json["subbrand"]).guid ?? '',
        subBrandName: json["subbrand"] == null
            ? null
            : Brand.fromJson(json["subbrand"]).name ?? '',
        departmentId: json["department"] == null
            ? null
            : Brand.fromJson(json["department"]).guid ?? '',
        departmentName: json["department"] == null
            ? null
            : Brand.fromJson(json["department"]).name ?? '',
      );

  Map<String, dynamic> toJson() => {
        "guid": guid,
        "fullname": fullname,
        "nickname": nickname,
        "date_of_birth":
            Helpers.formatDateOnlyForRequest(dateOfBirth ?? DateTime.now()),
        "gender": gender,
        "address_id_card": addressIdCard,
        "address_domicile": addressDomicile,
        "marital_status": maritalStatus,
        "education": education,
        "email": email,
        "phone_number": phoneNumber,
        "id_card": idCard,
        "npwp": npwp,
        "join_date":
            Helpers.formatDateOnlyForRequest(joinDate ?? DateTime.now()),
        "nik": nik,
        "bank_name": bankName,
        "bank_account": bankAccount,
        "insurance_number": insuranceNumber,
        "insurance_institution": insuranceInstitution,
        "bpjs_ketenagakerjaan": bpjsKetenagakerjaan,
        "url_profile_picture": urlProfilePicture,
        "about_me": aboutMe,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "interests": interests,
        "expertise": expertise,
        "cv_file_url": cvFileUrl,
        "url_social_media": urlSocialMedia == null
            ? []
            : List<dynamic>.from(urlSocialMedia!.map((x) => x)),
        "job_id": jobId,
        "job_name": jobName,
        "department_id": departmentId,
        "department_name": departmentName,
        "outlet_id": outletId,
        "outlet_name": outletName,
        "sub_brand_id": subBrandId,
        "sub_brand_name": subBrandName,
        "brand_id": brandId,
        "brand_name": brandName,
      };
}
