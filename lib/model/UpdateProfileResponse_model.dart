class UpdateProfileResponseModel {
  UpdateProfileResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late UpdateProfileResponseDataModel data;
  late String message;
  late List<String> errorList;
  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
        data: json["Data"] == null
            ? UpdateProfileResponseDataModel()
            : UpdateProfileResponseDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class UpdateProfileResponseDataModel {
  String? previousRequestStatus;
  String? cnicIssuedDate;
  String? imageUrl;
  String? NewImageName;
  String? userID;
  String? accountHolderName;
  String? accountHolderCNIC;
  String? email;
  String? phoneNumber;
  String? address;
  String? guardianType;
  String? fatherName;
  String? nextOfKinName;
  String? nextOfKinRelation;
  String? nextOfKinCNIC; //NextOfKinCNIC
  String? nextOfKinPhone;
  List<String> guardianTypes = ["Father", "Husband"];
  List<String> nextOfKinRelationList = [
    "Aunt",
    "Brother",
    "Cousin",
    "Daughter",
    "Father",
    "Friend",
    "Granddaughter",
    "Grandfather",
    "Grandmother",
    "Grandson",
    "Husband",
    "Mother",
    "Nephew",
    "Niece",
    "Self",
    "Sister",
    "Son",
    "Uncle",
    "Wife"
  ];

  UpdateProfileResponseDataModel(
      {this.previousRequestStatus,
      this.cnicIssuedDate,
      this.imageUrl,
      this.NewImageName,
      this.userID,
      this.accountHolderName,
      this.accountHolderCNIC,
      this.email,
      this.phoneNumber,
      this.address,
      this.guardianType,
      this.fatherName,
      this.nextOfKinName,
      this.nextOfKinRelation,
      this.nextOfKinCNIC,
      this.nextOfKinPhone});

  UpdateProfileResponseDataModel.fromJson(Map<String, dynamic> json) {
    previousRequestStatus = json['PreviousRequestStatus'];
    cnicIssuedDate = json['CnicIssuedDate'];
    NewImageName = json['NewImageName'];
    imageUrl = json['ImageUrl'];
    userID = json['UserId'];
    accountHolderName = json['AccountHolderName'];
    accountHolderCNIC = json['AccountHolderCNIC'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    address = json['Address'];
    guardianType = json['GuardianType'];
    fatherName = json['FatherName'];
    nextOfKinName = json['NextOfKinName'];
    nextOfKinRelation = json['NextOfKinRelation'];
    nextOfKinCNIC = json['NextOfKinCNIC']; //NextOfKinCNIC
    nextOfKinPhone = json['NextOfKinPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PreviousRequestStatus'] = this.previousRequestStatus;
    data['CnicIssuedDate'] = this.cnicIssuedDate;
    data['ImageUrl'] = this.imageUrl;
    data['NewImageName'] = this.NewImageName;
    data['UserId'] = this.userID;
    data['AccountHolderName'] = this.accountHolderName;
    data['AccountHolderCNIC'] = this.accountHolderCNIC;
    data['GuardianType'] = this.guardianType;
    data['Email'] = this.email;
    data['PhoneNumber'] = this.phoneNumber;
    data['Address'] = this.address;
    data['FatherName'] = this.fatherName;
    data['NextOfKinName'] = this.nextOfKinName;
    data['NextOfKinRelation'] = this.nextOfKinRelation;
    data['NextOfKinCNIC'] = this.nextOfKinCNIC;
    data['NextOfKinPhone'] = this.nextOfKinPhone;
    return data;
  }
}
