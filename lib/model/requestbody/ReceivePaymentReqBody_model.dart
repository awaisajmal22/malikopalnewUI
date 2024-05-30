class ReceivePaymentReqBodyModel {
  ReceivePaymentReqBodyModel({
    this.data,
  });

  final ReceivePaymentReqDataModel? data;

  factory ReceivePaymentReqBodyModel.fromJson(Map<String, dynamic> json) =>
      ReceivePaymentReqBodyModel(
        data: ReceivePaymentReqDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class ReceivePaymentReqDataModel {
  num? transferAmount;
  num? rolloverAmount;
  String? source;

  ReceivePaymentReqDataModel(
      {this.transferAmount, this.rolloverAmount, this.source});

  ReceivePaymentReqDataModel.fromJson(Map<String, dynamic> json) {
    transferAmount = json['TransferAmount'];
    rolloverAmount = json['RolloverAmount'];
    source = json['Source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransferAmount'] = this.transferAmount;
    data['RolloverAmount'] = this.rolloverAmount;
    data['Source'] = this.source;
    return data;
  }
}
