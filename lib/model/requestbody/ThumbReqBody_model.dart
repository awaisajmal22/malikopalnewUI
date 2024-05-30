class ThumbReqBodyModel {
  ThumbReqBodyModel({
    this.data,
  });

  final ThumbReqDataModel? data;

  factory ThumbReqBodyModel.fromJson(Map<String, dynamic> json) => ThumbReqBodyModel(
        data: ThumbReqDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class ThumbReqDataModel {
  ThumbReqDataModel({this.Activate, this.DeviceId, this.LoginMethod});

  var Activate;
  var DeviceId;
  var LoginMethod;
  factory ThumbReqDataModel.fromJson(Map<String, dynamic> json) => ThumbReqDataModel(
      Activate: json["Activate"],
      DeviceId: json["DeviceId"],
      LoginMethod: json["LoginMethod"]);

  Map<String, dynamic> toJson() =>
      {"Activate": Activate, "DeviceId": DeviceId, "LoginMethod": LoginMethod};
}
