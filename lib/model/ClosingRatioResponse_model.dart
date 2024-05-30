class ClosingRatioResponseModel {
  ClosingRatioResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late ClosingRatioResponseDataModel data;
  late String message;
  late List<String> errorList;
  factory ClosingRatioResponseModel.fromJson(Map<String, dynamic> json) =>
      ClosingRatioResponseModel(
        data: json["Data"] == null
            ? ClosingRatioResponseDataModel()
            : ClosingRatioResponseDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class ClosingRatioResponseDataModel {
  num? closingRatio;
  String? closingRatioText;

  ClosingRatioResponseDataModel({this.closingRatio, this.closingRatioText});

  ClosingRatioResponseDataModel.fromJson(Map<String, dynamic> json) {
    closingRatio = json['ClosingRatio'];
    closingRatioText = json['ClosingRatioText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClosingRatio'] = this.closingRatio;
    data['ClosingRatioText'] = this.closingRatioText;
    return data;
  }
}
