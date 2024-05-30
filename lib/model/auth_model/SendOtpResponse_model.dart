class SendOtpResponseModel {
  SendOtpResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late SendOtpResponseDataModel data;
  late String message;
  late List<String> errorList;
  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      SendOtpResponseModel(
        data: json["Data"] == null
            ? SendOtpResponseDataModel(Type: '', EmailPhone: '')
            : SendOtpResponseDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class SendOtpResponseDataModel {
  SendOtpResponseDataModel({
    this.Type,
    this.EmailPhone,
  });
  String? Type;
  String? EmailPhone;

  factory SendOtpResponseDataModel.fromJson(Map<String, dynamic> json) =>
      SendOtpResponseDataModel(Type: json["Type"], EmailPhone: json["EmailPhone"]);

  Map<String, dynamic> toJson() => {"Type": Type, "EmailPhone": EmailPhone};
}
