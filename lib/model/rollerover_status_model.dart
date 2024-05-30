// To parse this JSON data, do
//
//     final rollerOverStatus = rollerOverStatusFromJson(jsonString);

import 'dart:convert';

RollerOverStatusModel rollerOverStatusModelFromJson(String str) =>
    RollerOverStatusModel.fromJson(json.decode(str));

String rollerOverStatusModelToJson(RollerOverStatusModel data) =>
    json.encode(data.toJson());

class RollerOverStatusModel {
  RollerOverStatusModel({
    this.data,
    this.message,
    this.errorList,
  });

  Data? data;
  dynamic message;
  List<String?>? errorList;

  factory RollerOverStatusModel.fromJson(Map<String, dynamic> json) =>
      RollerOverStatusModel(
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? null
            : List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data == null ? null : data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class Data {
  Data({
    this.status,
    this.closingPayment,
    this.rolloverRequest,
  });

  bool? status;
  num? closingPayment;
  RolloverRequest? rolloverRequest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["Status"] == null ? null : json["Status"],
        closingPayment:
            json["ClosingPayment"] == null ? null : json["ClosingPayment"],
        rolloverRequest: json["RolloverRequest"] == null
            ? null
            : RolloverRequest.fromJson(json["RolloverRequest"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status == null ? null : status,
        "ClosingPayment": closingPayment == null ? null : closingPayment,
        "RolloverRequest":
            rolloverRequest == null ? null : rolloverRequest?.toJson(),
      };
}

class RolloverRequest {
  RolloverRequest({
    this.closing,
    this.profile,
    this.id,
    this.profileId,
    this.closingId,
    this.requestDate,
    this.amount,
    this.status,
    this.statusChangeDate,
    this.emailSent,
    this.smsSent,
    this.active,
    this.source,
    this.sourceStamp,
    this.createdAt,
  });

  dynamic closing;
  dynamic profile;
  num? id;
  num? profileId;
  num? closingId;
  DateTime? requestDate;
  num? amount;
  String? status;
  dynamic statusChangeDate;
  bool? emailSent;
  bool? smsSent;
  bool? active;
  String? source;
  dynamic sourceStamp;
  DateTime? createdAt;

  factory RolloverRequest.fromJson(Map<String, dynamic> json) =>
      RolloverRequest(
        closing: json["Closing"],
        profile: json["Profile"],
        id: json["ID"] == null ? null : json["ID"],
        profileId: json["ProfileID"] == null ? null : json["ProfileID"],
        closingId: json["ClosingID"] == null ? null : json["ClosingID"],
        requestDate: json["RequestDate"] == null
            ? null
            : DateTime.parse(json["RequestDate"]),
        amount: json["Amount"] == null ? null : json["Amount"],
        status: json["Status"] == null ? null : json["Status"],
        statusChangeDate: json["StatusChangeDate"],
        emailSent: json["EmailSent"] == null ? null : json["EmailSent"],
        smsSent: json["SmsSent"] == null ? null : json["SmsSent"],
        active: json["Active"] == null ? null : json["Active"],
        source: json["Source"] == null ? null : json["Source"],
        sourceStamp: json["SourceStamp"],
        createdAt: json["CreatedAt"] == null
            ? null
            : DateTime.parse(json["CreatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "Closing": closing,
        "Profile": profile,
        "ID": id == null ? null : id,
        "ProfileID": profileId == null ? null : profileId,
        "ClosingID": closingId == null ? null : closingId,
        "RequestDate":
            requestDate == null ? null : requestDate?.toIso8601String(),
        "Amount": amount == null ? null : amount,
        "Status": status == null ? null : status,
        "StatusChangeDate": statusChangeDate,
        "EmailSent": emailSent == null ? null : emailSent,
        "SmsSent": smsSent == null ? null : smsSent,
        "Active": active == null ? null : active,
        "Source": source == null ? null : source,
        "SourceStamp": sourceStamp,
        "CreatedAt": createdAt == null ? null : createdAt?.toIso8601String(),
      };
}
