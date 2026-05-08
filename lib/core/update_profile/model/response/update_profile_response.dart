import 'dart:convert';

import '../../../profile/model/response/profile_response.dart';

UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());
String updateProfileDataToJson(UpdateProfileData data) => json.encode(data.toProfileJson());

class UpdateProfileResponse {
    String? appName;
    String? version;
    String? build;
    UpdateProfileResponseData? response;

    UpdateProfileResponse({
        this.appName,
        this.version,
        this.build,
        this.response,
    });

    factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
        appName: json["app_name"],
        version: json["version"],
        build: json["build"],
        response: json["response"] == null ? null : UpdateProfileResponseData.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "app_name": appName,
        "version": version,
        "build": build,
        "response": response?.toJson(),
    };
}

class UpdateProfileResponseData {
    String? code;
    String? status;
    UpdateProfileData? data;
    String? messageEn;
    String? messageId;

    UpdateProfileResponseData({
        this.code,
        this.status,
        this.data,
        this.messageEn,
        this.messageId,
    });

    factory UpdateProfileResponseData.fromJson(Map<String, dynamic> json) => UpdateProfileResponseData(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? null : UpdateProfileData.fromJson(json["data"]),
        messageEn: json["message_en"],
        messageId: json["message_id"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data?.toJson(),
        "message_en": messageEn,
        "message_id": messageId,
    };
}

class UpdateProfileData {
    String? guid;
    String? fullname;
    String? nickname;
    DateTime? dateOfBirth;
    String? gender;
    dynamic addressIdCard;
    dynamic addressDomicile;
    String? maritalStatus;
    String? education;
    String? email;
    String? phoneNumber;
    dynamic idCard;
    dynamic npwp;
    DateTime? joinDate;
    dynamic nik;
    dynamic bankName;
    dynamic bankAccount;
    dynamic insuranceNumber;
    dynamic insuranceInstitution;
    dynamic bpjsKetenagakerjaan;
    String? urlProfilePicture;
    String? aboutMe;
    List<String>? skills;
    String? interests;
    String? expertise;
    String? cvFileUrl;
    List<dynamic>? urlSocialMedia;
    Job? job;
    Outlet? outlet;
    String? status;
    DateTime? createdAt;
    String? createdBy;
    DateTime? updatedAt;
    String? updatedBy;

    UpdateProfileData({
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
        this.job,
        this.outlet,
        this.status,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
    });

    factory UpdateProfileData.fromJson(Map<String, dynamic> json) => UpdateProfileData(
        guid: json["guid"],
        fullname: json["fullname"],
        nickname: json["nickname"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        addressIdCard: json["address_id_card"],
        addressDomicile: json["address_domicile"],
        maritalStatus: json["marital_status"],
        education: json["education"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        idCard: json["id_card"],
        npwp: json["npwp"],
        joinDate: json["join_date"] == null ? null : DateTime.parse(json["join_date"]),
        nik: json["nik"],
        bankName: json["bank_name"],
        bankAccount: json["bank_account"],
        insuranceNumber: json["insurance_number"],
        insuranceInstitution: json["insurance_institution"],
        bpjsKetenagakerjaan: json["bpjs_ketenagakerjaan"],
        urlProfilePicture: json["url_profile_picture"],
        aboutMe: json["about_me"],
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
        interests: json["interests"],
        expertise: json["expertise"],
        cvFileUrl: json["cv_file_url"],
        urlSocialMedia: json["url_social_media"] == null ? [] : List<dynamic>.from(json["url_social_media"]!.map((x) => x)),
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
        outlet: json["outlet"] == null ? null : Outlet.fromJson(json["outlet"]),
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        updatedBy: json["updated_by"],
    );

    Map<String, dynamic> toJson() => {
        "guid": guid,
        "fullname": fullname,
        "nickname": nickname,
        "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "address_id_card": addressIdCard,
        "address_domicile": addressDomicile,
        "marital_status": maritalStatus,
        "education": education,
        "email": email,
        "phone_number": phoneNumber,
        "id_card": idCard,
        "npwp": npwp,
        "join_date": "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "nik": nik,
        "bank_name": bankName,
        "bank_account": bankAccount,
        "insurance_number": insuranceNumber,
        "insurance_institution": insuranceInstitution,
        "bpjs_ketenagakerjaan": bpjsKetenagakerjaan,
        "url_profile_picture": urlProfilePicture,
        "about_me": aboutMe,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "interests": interests,
        "expertise": expertise,
        "cv_file_url": cvFileUrl,
        "url_social_media": urlSocialMedia == null ? [] : List<dynamic>.from(urlSocialMedia!.map((x) => x)),
        "job": job?.toJson(),
        "outlet": outlet?.toJson(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_at": updatedAt?.toIso8601String(),
        "updated_by": updatedBy,
    };

    Map<String, dynamic> toProfileJson() => {
        "about_me": aboutMe,
        "address_domicile": addressDomicile,
        "address_id_card": addressIdCard,
        "bank_account": bankAccount,
        "bank_name": bankName,
        "bpjs_ketenagakerjaan": bpjsKetenagakerjaan,
        "brand": Brand(guid: outlet?.brandId, name: outlet?.brandName),
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "cv_file_url": cvFileUrl,
        "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "department": Brand(guid: job?.departmentId, name: job?.departmentName),
        "education": education,
        "email": email,
        "expertise": expertise,
        "fullname": fullname,
        "gender": gender,
        "group": Brand(guid: outlet?.groupId, name: outlet?.groupName),
        "guid": guid,
        "id_card": idCard,
        "insurance_institution": insuranceInstitution,
        "insurance_number": insuranceNumber,
        "interests": interests,
        "job": Brand(guid: job?.jobId, name: job?.jobName),
        "marital_status": maritalStatus,
        "nickname": nickname,
        "npwp": npwp,
        "outlet": Brand(guid: outlet?.outletId, name: outlet?.outletName),
        "phone_number": phoneNumber,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "subbrand": Brand(guid: outlet?.subBrandId, name: outlet?.subBrandName),
        "updated_at": updatedAt?.toIso8601String(),
        "updated_by": updatedBy,
        "url_profile_picture": urlProfilePicture,
        "url_social_media": urlSocialMedia == null ? [] : List<dynamic>.from(urlSocialMedia!.map((x) => x)),
    };
}

class Job {
    DateTime? joinDate;
    dynamic nik;
    String? jobId;
    String? jobName;
    String? departmentId;
    String? departmentName;

    Job({
        this.joinDate,
        this.nik,
        this.jobId,
        this.jobName,
        this.departmentId,
        this.departmentName,
    });

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        joinDate: json["join_date"] == null ? null : DateTime.parse(json["join_date"]),
        nik: json["nik"],
        jobId: json["job_id"],
        jobName: json["job_name"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
    );

    Map<String, dynamic> toJson() => {
        "join_date": "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "nik": nik,
        "job_id": jobId,
        "job_name": jobName,
        "department_id": departmentId,
        "department_name": departmentName,
    };
}

class Outlet {
    String? outletId;
    String? outletName;
    String? brandId;
    String? brandName;
    String? subBrandId;
    String? subBrandName;
    String? groupId;
    String? groupName;

    Outlet({
        this.outletId,
        this.outletName,
        this.brandId,
        this.brandName,
        this.subBrandId,
        this.subBrandName,
        this.groupId,
        this.groupName,
    });

    factory Outlet.fromJson(Map<String, dynamic> json) => Outlet(
        outletId: json["outlet_id"],
        outletName: json["outlet_name"],
        brandId: json["brand_id"],
        brandName: json["brand_name"],
        subBrandId: json["sub_brand_id"],
        subBrandName: json["sub_brand_name"],
        groupId: json["group_id"],
        groupName: json["group_name"],
    );

    Map<String, dynamic> toJson() => {
        "outlet_id": outletId,
        "outlet_name": outletName,
        "brand_id": brandId,
        "brand_name": brandName,
        "sub_brand_id": subBrandId,
        "sub_brand_name": subBrandName,
        "group_id": groupId,
        "group_name": groupName,
    };
}