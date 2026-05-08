import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  ProfileResponse.fromJson(dynamic json) {
    appName = json['app_name'];
    version = json['version'];
    build = json['build'];
    response = json['response'] != null
        ? ProfileResponseData.fromJson(json['response'])
        : null;
  }

  String? appName;
  String? version;
  String? build;
  ProfileResponseData? response;

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

ProfileResponseData responseFromJson(String str) =>
    ProfileResponseData.fromJson(json.decode(str));

String responseToJson(ProfileResponseData data) => json.encode(data.toJson());

class ProfileResponseData {
  ProfileResponseData({
    this.code,
    this.status,
    this.data,
    this.messageEn,
    this.messageId,
  });

  ProfileResponseData.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
    messageEn = json['message_en'];
    messageId = json['message_id'];
  }

  String? code;
  String? status;
  ProfileData? data;
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

ProfileData dataFromJson(String str) => ProfileData.fromJson(json.decode(str));

String dataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  ProfileData({
    this.authenticationGuid,
    this.username,
    this.isActive,
    this.role,
    this.lastLogin,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.detailData,
  });

  ProfileData.fromJson(dynamic json) {
    authenticationGuid = json['authentication_guid'];
    username = json['username'];
    isActive = json['is_active'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    detailData = json['detail_data'] != null
        ? ProfileDetailData.fromJson(json['detail_data'])
        : null;
  }

  String? authenticationGuid;
  String? username;
  bool? isActive;
  Role? role;
  String? lastLogin;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  ProfileDetailData? detailData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['authentication_guid'] = authenticationGuid;
    map['username'] = username;
    map['is_active'] = isActive;
    if (role != null) {
      map['role'] = role?.toJson();
    }
    map['last_login'] = lastLogin;
    map['created_at'] = createdAt;
    map['created_by'] = createdBy;
    map['updated_at'] = updatedAt;
    map['updated_by'] = updatedBy;
    if (detailData != null) {
      map['detail_data'] = detailData?.toJson();
    }
    return map;
  }
}

ProfileDetailData detailDataFromJson(String str) =>
    ProfileDetailData.fromJson(json.decode(str));

String detailDataToJson(ProfileDetailData data) => json.encode(data.toJson());

class ProfileDetailData {
  String? aboutMe;
  String? addressDomicile;
  String? addressIdCard;
  String? bankAccount;
  String? bankName;
  String? bpjsKetenagakerjaan;
  Brand? brand;
  DateTime? createdAt;
  String? createdBy;
  String? cvFileUrl;
  DateTime? dateOfBirth;
  Brand? department;
  String? education;
  String? email;
  String? expertise;
  String? fullname;
  String? gender;
  Brand? group;
  String? guid;
  dynamic idCard;
  dynamic insuranceInstitution;
  dynamic insuranceNumber;
  String? interests;
  Brand? job;
  String? maritalStatus;
  String? nickname;
  dynamic npwp;
  Brand? outlet;
  String? phoneNumber;
  List<String>? skills;
  Brand? subbrand;
  DateTime? updatedAt;
  String? updatedBy;
  String? urlProfilePicture;
  List<dynamic>? urlSocialMedia;

  ProfileDetailData({
    this.aboutMe,
    this.addressDomicile,
    this.addressIdCard,
    this.bankAccount,
    this.bankName,
    this.bpjsKetenagakerjaan,
    this.brand,
    this.createdAt,
    this.createdBy,
    this.cvFileUrl,
    this.dateOfBirth,
    this.department,
    this.education,
    this.email,
    this.expertise,
    this.fullname,
    this.gender,
    this.group,
    this.guid,
    this.idCard,
    this.insuranceInstitution,
    this.insuranceNumber,
    this.interests,
    this.job,
    this.maritalStatus,
    this.nickname,
    this.npwp,
    this.outlet,
    this.phoneNumber,
    this.skills,
    this.subbrand,
    this.updatedAt,
    this.updatedBy,
    this.urlProfilePicture,
    this.urlSocialMedia,
  });

  factory ProfileDetailData.fromJson(Map<String, dynamic> json) =>
      ProfileDetailData(
        aboutMe: json["about_me"],
        addressDomicile: json["address_domicile"],
        addressIdCard: json["address_id_card"],
        bankAccount: json["bank_account"],
        bankName: json["bank_name"],
        bpjsKetenagakerjaan: json["bpjs_ketenagakerjaan"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        cvFileUrl: json["cv_file_url"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        department: json["department"] == null
            ? null
            : Brand.fromJson(json["department"]),
        education: json["education"],
        email: json["email"],
        expertise: json["expertise"],
        fullname: json["fullname"],
        gender: json["gender"],
        group: json["group"] == null ? null : Brand.fromJson(json["group"]),
        guid: json["guid"],
        idCard: json["id_card"],
        insuranceInstitution: json["insurance_institution"],
        insuranceNumber: json["insurance_number"],
        interests: json["interests"],
        job: json["job"] == null ? null : Brand.fromJson(json["job"]),
        maritalStatus: json["marital_status"],
        nickname: json["nickname"],
        npwp: json["npwp"],
        outlet: json["outlet"] == null ? null : Brand.fromJson(json["outlet"]),
        phoneNumber: json["phone_number"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        subbrand:
            json["subbrand"] == null ? null : Brand.fromJson(json["subbrand"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        updatedBy: json["updated_by"],
        urlProfilePicture: json["url_profile_picture"],
        urlSocialMedia: json["url_social_media"] == null
            ? []
            : List<dynamic>.from(json["url_social_media"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "about_me": aboutMe,
        "address_domicile": addressDomicile,
        "address_id_card": addressIdCard,
        "bank_account": bankAccount,
        "bank_name": bankName,
        "bpjs_ketenagakerjaan": bpjsKetenagakerjaan,
        "brand": brand?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "cv_file_url": cvFileUrl,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "department": department?.toJson(),
        "education": education,
        "email": email,
        "expertise": expertise,
        "fullname": fullname,
        "gender": gender,
        "group": group?.toJson(),
        "guid": guid,
        "id_card": idCard,
        "insurance_institution": insuranceInstitution,
        "insurance_number": insuranceNumber,
        "interests": interests,
        "job": job?.toJson(),
        "marital_status": maritalStatus,
        "nickname": nickname,
        "npwp": npwp,
        "outlet": outlet?.toJson(),
        "phone_number": phoneNumber,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "subbrand": subbrand?.toJson(),
        "updated_at": updatedAt?.toIso8601String(),
        "updated_by": updatedBy,
        "url_profile_picture": urlProfilePicture,
        "url_social_media": urlSocialMedia == null
            ? []
            : List<dynamic>.from(urlSocialMedia!.map((x) => x)),
      };
}

class Brand {
  String? guid;
  String? name;

  Brand({
    this.guid,
    this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        guid: json["guid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "guid": guid,
        "name": name,
      };
}

UrlSocialMedia urlSocialMediaFromJson(String str) =>
    UrlSocialMedia.fromJson(json.decode(str));

String urlSocialMediaToJson(UrlSocialMedia data) => json.encode(data.toJson());

class UrlSocialMedia {
  UrlSocialMedia({
    this.url,
    this.platform,
    this.usernames,
  });

  UrlSocialMedia.fromJson(dynamic json) {
    url = json['url'];
    platform = json['platform'];
    usernames = json['usernames'];
  }

  String? url;
  String? platform;
  String? usernames;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['platform'] = platform;
    map['usernames'] = usernames;
    return map;
  }
}

Role roleFromJson(String str) => Role.fromJson(json.decode(str));

String roleToJson(Role data) => json.encode(data.toJson());

class Role {
  Role({
    this.guid,
    this.roles,
  });

  Role.fromJson(dynamic json) {
    guid = json['guid'];
    roles = json['roles'];
  }

  String? guid;
  String? roles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['guid'] = guid;
    map['roles'] = roles;
    return map;
  }
}
