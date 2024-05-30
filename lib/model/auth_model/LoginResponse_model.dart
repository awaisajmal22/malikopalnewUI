import 'package:malikopal/model/auth_model/LoginData_model.dart';

class UserLoginResponseModel {
  UserLoginResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late UserLoginDataModel data;
  late String message;
  late List<String> errorList;
  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseModel(
        data: json["Data"] == null
            ? UserLoginDataModel(token: '')
            : UserLoginDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}
