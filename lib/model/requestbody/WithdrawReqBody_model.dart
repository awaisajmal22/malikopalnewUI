class WithdrawReqBodyModel {
  WithdrawReqBodyModel({
    this.data,
  });

  final WithdrawReqDataModel? data;

  factory WithdrawReqBodyModel.fromJson(Map<String, dynamic> json) =>
      WithdrawReqBodyModel(
        data: WithdrawReqDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class WithdrawReqDataModel {
  num? withdrawAmount;
  String? source;

  WithdrawReqDataModel({this.withdrawAmount, this.source});

  WithdrawReqDataModel.fromJson(Map<String, dynamic> json) {
    withdrawAmount = json['WithdrawAmount'];
    source = json['Source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WithdrawAmount'] = this.withdrawAmount;
    data['Source'] = this.source;
    return data;
  }
}
