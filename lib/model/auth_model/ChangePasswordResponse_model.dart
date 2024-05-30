import 'package:malikopal/model/requestbody/ChangePasswordReqBody_model.dart';

class ChangePasswordResponseModel {
  ChangePasswordResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late ChangePasswordReqDataModel data;
  late String message;
  late List<String> errorList;
  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponseModel(
        data: json["Data"] == null
            ? ChangePasswordReqDataModel(
                ConfirmPassword: '', NewPassword: '', OldPassword: '')
            : ChangePasswordReqDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}
