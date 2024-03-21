class LoginDataResponse {
  int? id;
  String? name;
  String? username;
  String? email;
  int? semiscode;
  int? role;
  String? contact;
  String? cnic;
  String? deviceID;
  int? resetPassword;
  String? lastAttendanceDate;
  String? lastTeacherAttendanceDate;
  int? securityCode;
  String? isManualAttendanceModuleEnabled;
  String? isLeaveModuleEnabled;
  String? isPromotionModuleEnabled;
  String? schoolname;
  String? district;
  String? taluka;
  String? uc;
  String? location;
  String? address;
  String? gender;
  String? medium;
  String? level;
  String? lastSequenceNumber;
  String? currentYearFull;
  String? currentYearShort;

  LoginDataResponse({this.id, this.name, this.username, this.email, this.semiscode, this.role, this.contact, this.cnic, this.deviceID, this.resetPassword, this.lastAttendanceDate, this.lastTeacherAttendanceDate, this.securityCode, this.isManualAttendanceModuleEnabled, this.isLeaveModuleEnabled, this.isPromotionModuleEnabled, this.schoolname, this.district, this.taluka, this.uc, this.location, this.address, this.gender, this.medium, this.level, this.lastSequenceNumber, this.currentYearFull, this.currentYearShort});

  LoginDataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    semiscode = json['semis_code'];
    role = json['Role'];
    contact = json['contact'];
    cnic = json['cnic'];
    deviceID = json['DeviceID'];
    resetPassword = json['resetPassword'];
    lastAttendanceDate = json['LastAttendanceDate'];
    lastTeacherAttendanceDate = json['LastTeacherAttendanceDate'];
    securityCode = json['securityCode'];
    isManualAttendanceModuleEnabled = json['isManualAttendanceModuleEnabled'];
    isLeaveModuleEnabled = json['isLeaveModuleEnabled'];
    isPromotionModuleEnabled = json['isPromotionModuleEnabled'];
    schoolname = json['school_name'];
    district = json['district'];
    taluka = json['taluka'];
    uc = json['uc'];
    location = json['location'];
    address = json['address'];
    gender = json['gender'];
    medium = json['medium'];
    level = json['level'];
    lastSequenceNumber = json['lastSequenceNumber'];
    currentYearFull = json['currentYearFull'];
    currentYearShort = json['currentYearShort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['semis_code'] = semiscode;
    data['Role'] = role;
    data['contact'] = contact;
    data['cnic'] = cnic;
    data['DeviceID'] = deviceID;
    data['resetPassword'] = resetPassword;
    data['LastAttendanceDate'] = lastAttendanceDate;
    data['LastTeacherAttendanceDate'] = lastTeacherAttendanceDate;
    data['securityCode'] = securityCode;
    data['isManualAttendanceModuleEnabled'] = isManualAttendanceModuleEnabled;
    data['isLeaveModuleEnabled'] = isLeaveModuleEnabled;
    data['isPromotionModuleEnabled'] = isPromotionModuleEnabled;
    data['school_name'] = schoolname;
    data['district'] = district;
    data['taluka'] = taluka;
    data['uc'] = uc;
    data['location'] = location;
    data['address'] = address;
    data['gender'] = gender;
    data['medium'] = medium;
    data['level'] = level;
    data['lastSequenceNumber'] = lastSequenceNumber;
    data['currentYearFull'] = currentYearFull;
    data['currentYearShort'] = currentYearShort;
    return data;
  }
}

class Root {
  String? status;
  String? message;
  LoginDataResponse? data;
  String? accesstoken;

  Root({this.status, this.message, this.data, this.accesstoken});

  Root.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LoginDataResponse?.fromJson(json['data']) : null;
    accesstoken = json['access_token'];
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> loginDataResponse = Map<String, dynamic>();
    loginDataResponse['status'] = status;
    loginDataResponse['message'] = message;
    loginDataResponse['data'] = loginDataResponse!.toJson();
    loginDataResponse['access_token'] = accesstoken;
    return loginDataResponse;
  }*/
}

