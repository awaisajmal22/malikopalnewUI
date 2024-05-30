class ChangePasswordReqBodyModel {
  ChangePasswordReqBodyModel({
    this.data,
  });

  final ChangePasswordReqDataModel? data;

  factory ChangePasswordReqBodyModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordReqBodyModel(
        data: ChangePasswordReqDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class ChangePasswordReqDataModel {
  String OldPassword = "";
  String NewPassword = "";
  String ConfirmPassword = "";
  ChangePasswordReqDataModel(
      {required this.OldPassword,
      required this.NewPassword,
      required this.ConfirmPassword});

  ChangePasswordReqDataModel.fromJson(Map<String, dynamic> json) {
    OldPassword = json['OldPassword'] ?? "";
    NewPassword = json['NewPassword'] ?? "";
    ConfirmPassword = json['ConfirmPassword'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OldPassword'] = this.OldPassword;
    data['NewPassword'] = this.NewPassword;
    data['ConfirmPassword'] = this.ConfirmPassword;
    return data;
  }
}
