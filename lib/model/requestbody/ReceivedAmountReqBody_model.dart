class ReceivedAmountReqBodyModel {
  ReceivedAmountReqBodyModel({
    this.data,
  });

  final ReceivedAmountReqDataModel? data;

  factory ReceivedAmountReqBodyModel.fromJson(Map<String, dynamic> json) =>
      ReceivedAmountReqBodyModel(
        data: ReceivedAmountReqDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

/*
"SinceDateStr": "01-01-2021",
    "Filter": "Y",
    "DateStr": ""
     */

class ReceivedAmountReqDataModel {
  ReceivedAmountReqDataModel(
      {this.SinceDateStr, this.Filter, this.DateStr, this.profileId});

  var SinceDateStr;
  var Filter;
  var DateStr;
  num? profileId;
  factory ReceivedAmountReqDataModel.fromJson(Map<String, dynamic> json) =>
      ReceivedAmountReqDataModel(
          SinceDateStr: json["SinceDateStr"],
          Filter: json["Filter"],
          DateStr: json["DateStr"],
          profileId: json["profileId"]);

  Map<String, dynamic> toJson() => {
        "SinceDateStr": SinceDateStr,
        "Filter": Filter,
        "DateStr": DateStr,
        'profileId': profileId
      };
}
