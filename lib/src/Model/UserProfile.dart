// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.parUser,
    this.username,
    this.password,
    this.fullname,
    this.birthday,
    this.address,
    this.phone,
    this.email,
    this.cmt,
    this.cmtDate,
    this.cmtPlace,
    this.kyc1,
    this.kyc2,
    this.iskyc,
    this.packet,
    this.isroot,
    this.is2Fa,
    this.gsecret,
    this.cdate,
    this.isbus,
    this.isactive,
  });

  String parUser;
  String username;
  String password;
  String fullname;
  dynamic birthday;
  dynamic address;
  dynamic phone;
  String email;
  dynamic cmt;
  dynamic cmtDate;
  dynamic cmtPlace;
  dynamic kyc1;
  dynamic kyc2;
  String iskyc;
  String packet;
  String isroot;
  String is2Fa;
  String gsecret;
  String cdate;
  String isbus;
  String isactive;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    parUser: json["par_user"] == null ? null : json["par_user"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    birthday: json["birthday"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"] == null ? null : json["email"],
    cmt: json["cmt"],
    cmtDate: json["cmt_date"],
    cmtPlace: json["cmt_place"],
    kyc1: json["kyc1"],
    kyc2: json["kyc2"],
    iskyc: json["iskyc"] == null ? null : json["iskyc"],
    packet: json["packet"] == null ? null : json["packet"],
    isroot: json["isroot"] == null ? null : json["isroot"],
    is2Fa: json["is2fa"] == null ? null : json["is2fa"],
    gsecret: json["gsecret"] == null ? null : json["gsecret"],
    cdate: json["cdate"] == null ? null : json["cdate"],
    isbus: json["isbus"] == null ? null : json["isbus"],
    isactive: json["isactive"] == null ? null : json["isactive"],
  );

  Map<String, dynamic> toJson() => {
    "par_user": parUser == null ? null : parUser,
    "username": username == null ? null : username,
    "password": password == null ? null : password,
    "fullname": fullname == null ? null : fullname,
    "birthday": birthday,
    "address": address,
    "phone": phone,
    "email": email == null ? null : email,
    "cmt": cmt,
    "cmt_date": cmtDate,
    "cmt_place": cmtPlace,
    "kyc1": kyc1,
    "kyc2": kyc2,
    "iskyc": iskyc == null ? null : iskyc,
    "packet": packet == null ? null : packet,
    "isroot": isroot == null ? null : isroot,
    "is2fa": is2Fa == null ? null : is2Fa,
    "gsecret": gsecret == null ? null : gsecret,
    "cdate": cdate == null ? null : cdate,
    "isbus": isbus == null ? null : isbus,
    "isactive": isactive == null ? null : isactive,
  };
}
