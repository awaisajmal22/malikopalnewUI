// To parse this JSON data, do
//
//     final refrenceInUser = refrenceInUserFromJson(jsonString);

import 'dart:convert';

RefrenceInUserModel refrenceInUserModelFromJson(String str) =>
    RefrenceInUserModel.fromJson(json.decode(str));

String refrenceInUserModelToJson(RefrenceInUserModel data) => json.encode(data.toJson());

class RefrenceInUserModel {
  RefrenceInUserModel({
    this.data,
    this.message,
    this.errorList,
  });

  Data? data;
  dynamic message;
  List<dynamic>? errorList;

  factory RefrenceInUserModel.fromJson(Map<String, dynamic> json) => RefrenceInUserModel(
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? []
            : List<dynamic>.from(json["ErrorList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? []
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class Data {
  Data({
    this.showList,
    this.showData,
    this.memberCount,
    this.totalCapital,
    this.totalClosing,
    this.referenceNodes,
  });

  bool? showList;
  bool? showData;
  num? memberCount;
  num? totalCapital;
  num? totalClosing;
  List<ReferenceNode>? referenceNodes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        showList: json["ShowList"],
        showData: json["ShowData"],
        memberCount: json["MemberCount"],
        totalCapital: json["TotalCapital"],
        totalClosing: json["TotalClosing"],
        referenceNodes: json["ReferenceNodes"] == null
            ? []
            : List<ReferenceNode>.from(
                json["ReferenceNodes"]!.map((x) => ReferenceNode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ShowList": showList,
        "ShowData": showData,
        "MemberCount": memberCount,
        "TotalCapital": totalCapital,
        "TotalClosing": totalClosing,
        "ReferenceNodes": referenceNodes == null
            ? []
            : List<dynamic>.from(referenceNodes!.map((x) => x.toJson())),
      };
}

class ReferenceNode {
  ReferenceNode({
    this.profileId,
    this.userId,
    this.fullName,
    this.userCapitalAmount,
    this.allow,
    this.accountType,
    this.acd,
    this.memberCount,
    this.memberCapital,
    this.plusMemberCount,
    this.plusMemberCapital,
    this.referenceUserId,
    this.directReferenceUserId,
    this.recentClosingAmount,
  });

  num? profileId;
  String? userId;
  String? fullName;
  num? userCapitalAmount;
  bool? allow;
  String? accountType;
  DateTime? acd;
  num? memberCount;
  num? memberCapital;
  num? plusMemberCount;
  num? plusMemberCapital;
  String? referenceUserId;
  String? directReferenceUserId;
  num? recentClosingAmount;

  factory ReferenceNode.fromJson(Map<String, dynamic> json) => ReferenceNode(
        profileId: json["ProfileID"],
        userId: json["UserID"],
        fullName: json["FullName"],
        userCapitalAmount: json["UserCapitalAmount"],
        allow: json["Allow"],
        accountType: json["AccountType"],
        acd: json["ACD"] == null ? null : DateTime.parse(json["ACD"]),
        memberCount: json["MemberCount"],
        memberCapital: json["MemberCapital"],
        plusMemberCount: json["PlusMemberCount"],
        plusMemberCapital: json["PlusMemberCapital"],
        referenceUserId: json["ReferenceUserID"],
        directReferenceUserId: json["DirectReferenceUserID"],
        recentClosingAmount: json["RecentClosingAmount"],
      );

  Map<String, dynamic> toJson() => {
        "ProfileID": profileId,
        "UserID": userId,
        "FullName": fullName,
        "UserCapitalAmount": userCapitalAmount,
        "Allow": allow,
        "AccountType": accountType,
        "ACD": acd?.toIso8601String(),
        "MemberCount": memberCount,
        "MemberCapital": memberCapital,
        "PlusMemberCount": plusMemberCount,
        "PlusMemberCapital": plusMemberCapital,
        "ReferenceUserID": referenceUserId,
        "DirectReferenceUserID": directReferenceUserId,
        "RecentClosingAmount": recentClosingAmount,
      };
}
