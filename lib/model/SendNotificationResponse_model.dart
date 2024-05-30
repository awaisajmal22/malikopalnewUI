class SendNotificationResponseModel {
  SendNotificationResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late List<SendNotificationResponseDataModel>? data;
  late String message;
  late List<String> errorList;
  factory SendNotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      SendNotificationResponseModel(
        data: json["Data"] == null
            ? null
            : List<SendNotificationResponseDataModel>.from(json["Data"]
                .map((x) => SendNotificationResponseDataModel.fromJson(x))),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        // "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class SendNotificationResponseDataModel {
  num? notificationID;
  num? notificationUserID;
  String? title;
  String? desc;
  String? date;
  num? newMsgs;

  SendNotificationResponseDataModel(
      {this.notificationID,
      this.notificationUserID,
      this.title,
      this.desc,
      this.date,
      this.newMsgs});

  SendNotificationResponseDataModel.fromJson(Map<String, dynamic> json) {
    notificationID = json['NotificationID'];
    notificationUserID = json['NotificationUserID'];
    title = json['Title'];
    desc = json['Desc'];
    date = json['Date'];
    newMsgs = json['NewMsgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationID'] = this.notificationID;
    data['NotificationUserID'] = this.notificationUserID;
    data['Title'] = this.title;
    data['Desc'] = this.desc;
    data['Date'] = this.date;
    data['NewMsgs'] = this.newMsgs;
    return data;
  }
}
