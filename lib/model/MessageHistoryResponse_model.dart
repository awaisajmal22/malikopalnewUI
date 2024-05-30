class MessageHistoryResponseModel {
  MessageHistoryResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late List<MessageHistoryResponseDataModel>? data;

  late String message;
  late List<String> errorList;
  factory MessageHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      MessageHistoryResponseModel(
        data: json["Data"] == null
            ? null
            : List<MessageHistoryResponseDataModel>.from(json["Data"]
                .map((x) => MessageHistoryResponseDataModel.fromJson(x))),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        // "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class MessageHistoryResponseDataModel {
  num? id;
  String? text;
  String? sentBy;
  String? entryDate;
  bool? viewed;
  String? viewDate;

  MessageHistoryResponseDataModel(
      {this.id,
      this.text,
      this.sentBy,
      this.entryDate,
      this.viewed,
      this.viewDate});

  MessageHistoryResponseDataModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    text = json['Text'];
    sentBy = json['SentBy'];
    entryDate = json['EntryDate'];
    viewed = json['Viewed'];
    viewDate = json['ViewDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Text'] = this.text;
    data['SentBy'] = this.sentBy;
    data['EntryDate'] = this.entryDate;
    data['Viewed'] = this.viewed;
    data['ViewDate'] = this.viewDate;
    return data;
  }
}
