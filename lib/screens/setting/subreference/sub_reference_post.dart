// To parse this JSON data, do
//
//     final subRefencePostData = subRefencePostDataFromJson(jsonString);

import 'dart:convert';

SubRefencePostData subRefencePostDataFromJson(String str) =>
    SubRefencePostData.fromJson(json.decode(str));

String subRefencePostDataToJson(SubRefencePostData data) =>
    json.encode(data.toJson());

class SubRefencePostData {
  SubRefencePostData({
    this.data,
  });

  final SubRefeData? data;

  factory SubRefencePostData.fromJson(Map<String, dynamic> json) =>
      SubRefencePostData(
        data: json["Data"] == null ? null : SubRefeData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class SubRefeData {
  SubRefeData({
    this.profileId,
    this.startDate,
    this.endDate,
    this.duration,
    this.keyword,
  });

  final int? profileId;
  final String? startDate;
  final String? endDate;
  final String? duration;
  final String? keyword;

  factory SubRefeData.fromJson(Map<String, dynamic> json) => SubRefeData(
        profileId: json["ProfileId"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        duration: json["Duration"],
        keyword: json["Keyword"],
      );

  Map<String, dynamic> toJson() => {
        "ProfileId": profileId,
        "StartDate": startDate,
        "EndDate": endDate,
        "Duration": duration,
        "Keyword": keyword,
      };
}
