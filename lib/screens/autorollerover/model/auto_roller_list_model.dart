// To parse this JSON data, do
//
//     final AutoRollerOverListModel = AutoRollerOverListModelFromJson(jsonString);

import 'dart:convert';

AutoRollerOverListModel autoRollerOverListModelFromJson(String str) =>
    AutoRollerOverListModel.fromJson(json.decode(str));

String autoRollerOverListModelToJson(AutoRollerOverListModel data) =>
    json.encode(data.toJson());

class AutoRollerOverListModel {
  AutoRollerOverListModel({
    this.data,
    this.message,
    this.errorList,
  });

  final Data? data;
  final String? message;
  final List<dynamic>? errorList;

  factory AutoRollerOverListModel.fromJson(Map<String, dynamic> json) =>
      AutoRollerOverListModel(
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
  Data({this.status, this.types, this.RequestStatus, this.type, this.pending});

  final bool? status;
  int? type;
  final List<Type>? types;
  final String? RequestStatus;
  final dynamic pending;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      status: json["Status"],
      pending: json["Pending"],
      type: json["TypeID"],
      types: json["Types"] == null
          ? []
          : List<Type>.from(json["Types"]!.map((x) => Type.fromJson(x))),
      RequestStatus: json["RequestStatus"]);

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Types": types == null
            ? []
            : List<dynamic>.from(types!.map((x) => x.toJson())),
      };
}

class Type {
  Type({
    this.id,
    this.name,
    this.value,
    this.description,
  });

  final int? id;
  final String? name;
  final int? value;
  final String? description;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["ID"],
        name: json["Name"],
        value: json["Value"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Value": value,
        "Description": description,
      };
}
