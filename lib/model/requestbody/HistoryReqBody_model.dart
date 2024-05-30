class HistoryReqBodyModel {
  HistoryReqBodyModel({
    this.data,
  });

  final HistoryReqDataModel? data;

  factory HistoryReqBodyModel.fromJson(Map<String, dynamic> json) => HistoryReqBodyModel(
        data: HistoryReqDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class HistoryReqDataModel {
  String? startDate;
  String? endDate;
  String? duration;
  String? Keyword;
  num? pno;
  num? profileId = 0;

  HistoryReqDataModel(
      {this.Keyword,
      this.startDate,
      this.endDate,
      this.duration,
      this.pno,
      this.profileId});

  HistoryReqDataModel.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration = json['duration'];
    pno = json['pno'];
    Keyword = json['Keyword'];
    profileId = json['profileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['duration'] = this.duration;
    data['pno'] = this.pno;
    data['Keyword'] = this.Keyword;
    data['profileId'] = this.profileId;
    return data;
  }
}
