// To parse this JSON data, do
//
//     final transferRollover = transferRolloverFromJson(jsonString);

import 'dart:convert';

TransferRolloverModel transferRolloverModelFromJson(String str) =>
    TransferRolloverModel.fromJson(json.decode(str));

String transferRolloverModelToJson(TransferRolloverModel data) =>
    json.encode(data.toJson());

class TransferRolloverModel {
  TransferRolloverModel({
    this.data,
    this.message,
    this.errorList,
  });

  Data? data;
  dynamic message;
  List<String>? errorList;

  factory TransferRolloverModel.fromJson(Map<String, dynamic> json) =>
      TransferRolloverModel(
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
    this.transferRolloverRequest,
    this.remainingTime,
  });

  bool? status;
  num? closingPayment;
  RemainingTime? remainingTime;
  TransferRolloverRequest? transferRolloverRequest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["Status"] == null ? null : json["Status"],
        closingPayment:
            json["ClosingPayment"] == null ? null : json["ClosingPayment"],
        transferRolloverRequest: json["TransferRolloverRequest"] == null
            ? null
            : TransferRolloverRequest.fromJson(json["TransferRolloverRequest"]),
        remainingTime: json["RemaingTime"] == null
            ? null
            : RemainingTime.fromJson(json["RemaingTime"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status == null ? null : status,
        "ClosingPayment": closingPayment == null ? null : closingPayment,
        "RemaingTime": remainingTime == null ? null : remainingTime,
        "TransferRolloverRequest": transferRolloverRequest == null
            ? null
            : transferRolloverRequest?.toJson(),
      };
}

// class Data {
//   Data({
//     this.status,
//     this.closingPayment,
//     this.transferRolloverRequest,

//     this.remainingTime,
//   });

//   bool? status;
//   num? closingPayment;
//   RemainingTime? remainingTime;
//   TransferRolloverRequest? transferRolloverRequest;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         status: json["Status"] == null ? null : json["Status"],
//         closingPayment:
//             json["ClosingPayment"] == null ? null : json["ClosingPayment"],
//             transferRolloverRequest:   json["TransferRolloverRequest"] == null
//             ? null
//             : TransferRolloverRequest.fromJson(json["TransferRolloverRequest"]),
//         remainingTime: json["RemainingTime"] == null
//             ? null
//             : RemainingTime.fromJson(json["RemainingTime"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "Status": status == null ? null : status,
//         "ClosingPayment": closingPayment == null ? null : closingPayment,
//         "RemainingTime": remainingTime == null ? null : remainingTime?.toJson(),
//         "TransferRolloverRequest": transferRolloverRequest == null
//             ? null
//             : transferRolloverRequest?.toJson(),
//       };
// }

class RemainingTime {
  RemainingTime({
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });

  int? days;
  int? hours;
  int? minutes;
  int? seconds;

  String get formattedTime {
    Duration duration = Duration(
        days: days!, hours: hours!, minutes: minutes!, seconds: seconds!);
    int day = duration.inDays;
    int hour = duration.inHours;
    int minute = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    // final totalHours = (days ?? 0) * 24 +
    //     (hours ?? 0) +
    //     ((minutes ?? 0) / 60) +
    //     ((seconds ?? 0) / 3600);
    // final formattedHours = totalHours.toStringAsFixed(2);

    // return formattedHours;
    final formatedTime = '${_twoDigits(hour)}:${_twoDigits(minute)}';
    return formatedTime;
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  factory RemainingTime.fromJson(Map<String, dynamic> json) => RemainingTime(
        days: json["Days"] == null ? null : json["Days"],
        hours: json["Hours"] == null ? null : json["Hours"],
        minutes: json["Minutes"] == null ? null : json["Minutes"],
        seconds: json["Seconds"] == null ? null : json["Seconds"],
      );

  Map<String, dynamic> toJson() => {
        "Days": days == null ? null : days,
        "Hours": hours == null ? null : hours,
        "Minutes": minutes == null ? null : minutes,
        "Seconds": seconds == null ? null : seconds,
      };
}

class TransferRolloverRequest {
  TransferRolloverRequest({
    this.closingPayment,
    this.transfer,
    this.rollover,
    this.requestDate,
    this.status,
  });

  num? closingPayment;
  num? transfer;
  num? rollover;
  DateTime? requestDate;
  String? status;

  factory TransferRolloverRequest.fromJson(Map<String, dynamic> json) =>
      TransferRolloverRequest(
        closingPayment:
            json["ClosingPayment"] == null ? null : json["ClosingPayment"],
        transfer: json["Transfer"] == null ? null : json["Transfer"],
        rollover: json["Rollover"] == null ? null : json["Rollover"],
        requestDate: json["RequestDate"] == null
            ? null
            : DateTime.parse(json["RequestDate"]),
        status: json["Status"] == null ? null : json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "ClosingPayment": closingPayment == null ? null : closingPayment,
        "Transfer": transfer == null ? null : transfer,
        "Rollover": rollover == null ? null : rollover,
        "RequestDate":
            requestDate == null ? null : requestDate?.toIso8601String(),
        "Status": status == null ? null : status,
      };
}
