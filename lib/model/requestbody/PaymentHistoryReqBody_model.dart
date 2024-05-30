class PaymentHistoryReqBodyModel {
  PaymentHistoryReqBodyModel({
    this.data,
  });

  final PaymentHistoryReqDataModel? data;

  factory PaymentHistoryReqBodyModel.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryReqBodyModel(
        data: PaymentHistoryReqDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class PaymentHistoryReqDataModel {
  String? Month;
  String? Year;
  num? Pno;
  num? profileId;

  PaymentHistoryReqDataModel({this.Month, this.Year, this.Pno, this.profileId});

  PaymentHistoryReqDataModel.fromJson(Map<String, dynamic> json) {
    Month = json['Month'];
    Year = json['Year'];
    Pno = json['Pno'];
    profileId = json['profileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Month'] = this.Month;
    data['Year'] = this.Year;
    data['Pno'] = this.Pno;
    data['profileId'] = this.profileId;
    return data;
  }
}
