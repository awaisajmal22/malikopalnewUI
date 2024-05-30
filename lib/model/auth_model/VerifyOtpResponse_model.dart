class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  VerifyOtpResponseDataModel data;
  String message;
  List<String> errorList;
  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponseModel(
        data: json["Data"] == null
            ? VerifyOtpResponseDataModel(IsSuccess: false)
            : VerifyOtpResponseDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class VerifyOtpResponseDataModel {
  VerifyOtpResponseDataModel({
    required this.IsSuccess,
  });
  bool IsSuccess;

  factory VerifyOtpResponseDataModel.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponseDataModel(IsSuccess: json["IsSuccess"]);

  Map<String, dynamic> toJson() => {"IsSuccess": IsSuccess};
}
