class ClosingPaymentResponseModel {
  ClosingPaymentResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late ClosingPaymentResponseDataModel data;
  late String message;
  late List<String> errorList;
  factory ClosingPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      ClosingPaymentResponseModel(
        data: json["Data"] == null
            ? ClosingPaymentResponseDataModel()
            : ClosingPaymentResponseDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class ClosingPaymentResponseDataModel {
  num? ClosingPayment;
  bool? IsProfileRolloverEnable;
  String? TrRequestDate;
  num? TrRequestAmount;
  String? TrRequestStatus;

  String? RoRequestDate;
  String? RoRequestStatus;
  num? RoRequestAmount;

  ClosingPaymentResponseDataModel(
      {this.ClosingPayment,
      this.IsProfileRolloverEnable,
      this.TrRequestDate,
      this.TrRequestAmount,
      this.TrRequestStatus,
      this.RoRequestDate,
      this.RoRequestAmount,
      this.RoRequestStatus});

  ClosingPaymentResponseDataModel.fromJson(Map<String, dynamic> json) {
    ClosingPayment = json['ClosingPayment'];
    IsProfileRolloverEnable = json['IsProfileRolloverEnable'];
    TrRequestDate = json['TrRequestDate'];
    TrRequestAmount = json['TrRequestAmount'];
    TrRequestStatus = json['TrRequestStatus'];
    RoRequestDate = json['RoRequestDate'];
    RoRequestAmount = json['RoRequestAmount'];
    RoRequestStatus = json['RoRequestStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClosingPayment'] = this.ClosingPayment;
    data['IsProfileRolloverEnable'] = this.IsProfileRolloverEnable;
    data['TrRequestDate'] = this.TrRequestDate;
    data['TrRequestAmount'] = this.TrRequestAmount;
    data['TrRequestStatus'] = this.TrRequestStatus;

    data['RoRequestDate'] = this.RoRequestDate;
    data['RoRequestAmount'] = this.RoRequestAmount;
    data['RoRequestStatus'] = this.RoRequestStatus;
    return data;
  }
}
