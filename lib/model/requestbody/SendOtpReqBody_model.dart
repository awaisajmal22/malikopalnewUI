import 'package:malikopal/model/auth_model/LoginData_model.dart';

class SendOtpReqBodyModel {
  SendOtpReqBodyModel({
    this.data,
  });

  final SendOtpData? data;

  factory SendOtpReqBodyModel.fromJson(Map<String, dynamic> json) => SendOtpReqBodyModel(
        data: SendOtpData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class VerifyOtpReqBodyModel {
  VerifyOtpReqBodyModel({
    this.data,
  });

  final VerifyOtpData? data;

  factory VerifyOtpReqBodyModel.fromJson(Map<String, dynamic> json) =>
      VerifyOtpReqBodyModel(
        data: VerifyOtpData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}
