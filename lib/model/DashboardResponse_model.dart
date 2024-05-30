class DashboardResponseModel {
  DashboardResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late DashboardResponseDataModel data;
  late String message;
  late List<String> errorList;
  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardResponseModel(
        data: json["Data"] == null
            ? DashboardResponseDataModel(
                isBankUpdateRequired: false,
                isProfileUpdateRequired: false,
                isClosingDays: false,
                IsRefrenceInAllowed: false,
                IsShowDataAllowed: false,
                IsShowListAllowed: false,
                IsSubReferenceAllowed: false)
            : DashboardResponseDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class DashboardResponseDataModel {
  //

  String? userType;
  String? image;
  String? fullName;
  var totalCapital;
  int? NotificationCount;
  var UserName;

  bool IsRefrenceInAllowed = false;

  bool? IsSubReferenceAllowed = false;

  bool? IsShowListAllowed = false;

  bool? IsShowDataAllowed = false;
  bool? isClosingDays = false;
  bool? isProfileUpdateRequired = false;
  bool? isBankUpdateRequired = false;

  DashboardResponseDataModel(
      {this.userType,
      this.image,
      this.fullName,
      this.totalCapital,
      this.NotificationCount,
      this.UserName,
      this.isClosingDays,
      required this.IsRefrenceInAllowed,
      this.IsShowDataAllowed,
      this.isBankUpdateRequired,
      this.IsShowListAllowed,
      this.isProfileUpdateRequired,
      this.IsSubReferenceAllowed});

  DashboardResponseDataModel.fromJson(Map<String, dynamic> json) {
    userType = json['UserType'];
    image = json['Image'];
    fullName = json['FullName'];
    totalCapital = json['TotalCapital'];
    NotificationCount = json['NotificationCount'];
    UserName = json['UserName'];
    IsRefrenceInAllowed = json['IsRefrenceInAllowed'];
    IsSubReferenceAllowed = json['IsSubReferenceAllowed'];
    IsShowListAllowed = json['IsShowListAllowed'];
    IsShowDataAllowed = json['IsShowDataAllowed'];
    isClosingDays = json['IsClosingDays'];
    isProfileUpdateRequired = json['IsProfileUpdateRequired'];
    isBankUpdateRequired = json['IsBankUpdateRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserType'] = this.userType;
    data['Image'] = this.image;
    data['FullName'] = this.fullName;
    data['TotalCapital'] = this.totalCapital;
    data['NotificationCount'] = this.NotificationCount;
    data['UserName'] = this.UserName;
    data['IsRefrenceInAllowed'] = this.IsRefrenceInAllowed;
    data['IsSubReferenceAllowed'] = this.IsSubReferenceAllowed;
    data['IsShowListAllowed'] = this.IsShowListAllowed;
    data['IsShowDataAllowed'] = this.IsShowDataAllowed;
    data['IsClosingDays'] = this.isClosingDays;
    data['IsProfileUpdateRequired'] = this.isProfileUpdateRequired;
    data['IsBankUpdateRequired'] = this.isBankUpdateRequired;
    return data;
  }
}
