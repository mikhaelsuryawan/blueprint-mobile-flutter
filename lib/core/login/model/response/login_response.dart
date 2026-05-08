import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  LoginResponse.fromJson(dynamic json) {
    appName = json['app_name'];
    version = json['version'];
    build = json['build'];
    response = json['response'] != null
        ? LoginResponseData.fromJson(json['response'])
        : null;
  }

  String? appName;
  String? version;
  String? build;
  LoginResponseData? response;

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

LoginResponseData responseFromJson(String str) =>
    LoginResponseData.fromJson(json.decode(str));

String responseToJson(LoginResponseData data) => json.encode(data.toJson());

class LoginResponseData {
  LoginResponseData({
    this.code,
    this.status,
    this.data,
    this.messageEn,
    this.messageId,
  });

  LoginResponseData.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    messageEn = json['message_en'];
    messageId = json['message_id'];
  }

  String? code;
  String? status;
  LoginData? data;
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

LoginData dataFromJson(String str) => LoginData.fromJson(json.decode(str));

String dataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.guid,
    this.usersGuid,
    this.username,
    this.roles,
    this.employeeDetail,
    this.isActive,
    this.createdAt,
    this.createdBy,
  });

  LoginData.fromJson(dynamic json) {
    guid = json['guid'];
    usersGuid = json['users_guid'];
    username = json['username'];
    roles = json['roles'] != null ? Roles.fromJson(json['roles']) : null;
    employeeDetail = json['employee_detail'] != null
        ? EmployeeDetail.fromJson(json['employee_detail'])
        : null;
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
  }

  String? guid;
  String? usersGuid;
  String? username;
  Roles? roles;
  EmployeeDetail? employeeDetail;
  bool? isActive;
  String? createdAt;
  String? createdBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['guid'] = guid;
    map['users_guid'] = usersGuid;
    map['username'] = username;
    if (roles != null) {
      map['roles'] = roles?.toJson();
    }
    if (employeeDetail != null) {
      map['employee_detail'] = employeeDetail?.toJson();
    }
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['created_by'] = createdBy;
    return map;
  }
}

EmployeeDetail employeeDetailFromJson(String str) =>
    EmployeeDetail.fromJson(json.decode(str));

String employeeDetailToJson(EmployeeDetail data) => json.encode(data.toJson());

class EmployeeDetail {
  EmployeeDetail({
    this.guid,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.job,
    this.outlet,
    this.status,
  });

  EmployeeDetail.fromJson(dynamic json) {
    guid = json['guid'];
    fullname = json['fullname'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
    outlet = json['outlet'] != null ? Outlet.fromJson(json['outlet']) : null;
    status = json['status'];
  }

  String? guid;
  String? fullname;
  String? email;
  String? phoneNumber;
  Job? job;
  Outlet? outlet;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['guid'] = guid;
    map['fullname'] = fullname;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    if (job != null) {
      map['job'] = job?.toJson();
    }
    if (outlet != null) {
      map['outlet'] = outlet?.toJson();
    }
    map['status'] = status;
    return map;
  }
}

Outlet outletFromJson(String str) => Outlet.fromJson(json.decode(str));

String outletToJson(Outlet data) => json.encode(data.toJson());

class Outlet {
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

  Outlet.fromJson(dynamic json) {
    outletId = json['outlet_id'];
    outletName = json['outlet_name'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    subBrandId = json['sub_brand_id'];
    subBrandName = json['sub_brand_name'];
    groupId = json['group_id'];
    groupName = json['group_name'];
  }

  String? outletId;
  String? outletName;
  String? brandId;
  String? brandName;
  String? subBrandId;
  String? subBrandName;
  String? groupId;
  String? groupName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['outlet_id'] = outletId;
    map['outlet_name'] = outletName;
    map['brand_id'] = brandId;
    map['brand_name'] = brandName;
    map['sub_brand_id'] = subBrandId;
    map['sub_brand_name'] = subBrandName;
    map['group_id'] = groupId;
    map['group_name'] = groupName;
    return map;
  }
}

Job jobFromJson(String str) => Job.fromJson(json.decode(str));

String jobToJson(Job data) => json.encode(data.toJson());

class Job {
  Job({
    this.joinDate,
    this.nik,
    this.jobId,
    this.jobName,
    this.departmentId,
    this.departmentName,
  });

  Job.fromJson(dynamic json) {
    joinDate = json['join_date'];
    nik = json['nik'];
    jobId = json['job_id'];
    jobName = json['job_name'];
    departmentId = json['department_id'];
    departmentName = json['department_name'];
  }

  String? joinDate;
  String? nik;
  String? jobId;
  String? jobName;
  String? departmentId;
  String? departmentName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['join_date'] = joinDate;
    map['nik'] = nik;
    map['job_id'] = jobId;
    map['job_name'] = jobName;
    map['department_id'] = departmentId;
    map['department_name'] = departmentName;
    return map;
  }
}

Roles rolesFromJson(String str) => Roles.fromJson(json.decode(str));

String rolesToJson(Roles data) => json.encode(data.toJson());

class Roles {
  Roles({
    this.guid,
    this.name,
  });

  Roles.fromJson(dynamic json) {
    guid = json['guid'];
    name = json['name'];
  }

  String? guid;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['guid'] = guid;
    map['name'] = name;
    return map;
  }
}
