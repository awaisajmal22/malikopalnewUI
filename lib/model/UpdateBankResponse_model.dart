class UpdateBankResponseModel {
  UpdateBankResponseModel({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late UpdateBankResponseDataModel data;
  late String message;
  late List<String> errorList;
  factory UpdateBankResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateBankResponseModel(
        data: json["Data"] == null
            ? UpdateBankResponseDataModel()
            : UpdateBankResponseDataModel.fromJson(json["Data"]),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class UpdateBankResponseDataModel {
  String? previousRequestStatus;
  String? createdAt;
  String? bankName;
  String? accountTitle;
  String? branchCode;
  String? accountNo;
  String? iban;
  List<String>? bankNames;

  String? accountRelation;
  List<String> accountRelationList = [
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
  UpdateBankResponseDataModel(
      {this.previousRequestStatus,
      this.createdAt,
      this.bankName,
      this.accountTitle,
      this.branchCode,
      this.accountNo,
      this.iban,
      this.bankNames,
      this.accountRelation});

  UpdateBankResponseDataModel.fromJson(Map<String, dynamic> json) {
    previousRequestStatus = json['PreviousRequestStatus'];
    createdAt = json['CreatedAt'];
    bankName = json['BankName'];
    accountTitle = json['AccountTitle'];
    branchCode = json['BranchCode'];
    accountNo = json['AccountNo'];
    iban = json['IBAN'];
    if (json['BankNames'] != null) {
      bankNames = <String>[];
      json['BankNames'].forEach((v) {
        bankNames?.add(v?.toString() ?? "");
      });
    }
    accountRelation = json['AccountRelation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PreviousRequestStatus'] = this.previousRequestStatus;
    data['CreatedAt'] = this.createdAt;
    data['BankName'] = this.bankName;
    data['AccountTitle'] = this.accountTitle;
    data['BranchCode'] = this.branchCode;
    data['AccountNo'] = this.accountNo;
    data['IBAN'] = this.iban;
    if (this.bankNames != null) {
      data['BankNames'] = this.bankNames!.map((v) => v).toList();
    }
    data['AccountRelation'] = this.accountRelation;
    return data;
  }
}
