import 'package:malikopal/model/auth_model/LoginData_model.dart';

class UserLoginReqBodyModel {
  UserLoginReqBodyModel({
    this.data,
  });

  final LoginFormDataModel? data;

  factory UserLoginReqBodyModel.fromJson(Map<String, dynamic> json) =>
      UserLoginReqBodyModel(
        data: LoginFormDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}
