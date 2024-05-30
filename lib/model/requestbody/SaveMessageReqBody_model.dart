class SaveMessageReqBodyModel {
  SaveMessageReqBodyModel({
    this.data,
  });

  final SaveMessageReqBodyDataModel? data;

  factory SaveMessageReqBodyModel.fromJson(Map<String, dynamic> json) =>
      SaveMessageReqBodyModel(
        data: SaveMessageReqBodyDataModel.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class SaveMessageReqBodyDataModel {
  num? iD;
  num? profileID;
  String? text;
  String? sentBy;
  String? entryDate;
  bool? viewed;
  String? viewDate;

  SaveMessageReqBodyDataModel(
      {this.iD,
      this.profileID,
      this.text,
      this.sentBy,
      this.entryDate,
      this.viewed,
      this.viewDate});

  SaveMessageReqBodyDataModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    profileID = json['ProfileID'];
    text = json['Text'];
    sentBy = json['SentBy'];
    entryDate = json['EntryDate'];
    viewed = json['Viewed'];
    viewDate = json['ViewDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ProfileID'] = this.profileID;
    data['Text'] = this.text;
    data['SentBy'] = this.sentBy;
    data['EntryDate'] = this.entryDate;
    data['Viewed'] = this.viewed;
    data['ViewDate'] = this.viewDate;
    return data;
  }
}
