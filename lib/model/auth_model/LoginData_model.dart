class UserInfoModel {
  bool? isSuccess;
  Response? response;
  String? errorMessage;

  UserInfoModel({this.isSuccess, this.response, this.errorMessage});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    //

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['isSuccess'] = this.isSuccess;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class Response{
  String? userType;
  String? image;
  String? fullName;
  num? totalCapital;
  num? closingPayment;
  num? lastAmountAdded;
  String? lastAmountDate;

  Response(
      {this.userType,
      this.image,
      this.fullName,
      this.totalCapital,
      this.closingPayment,
      this.lastAmountAdded,
      this.lastAmountDate});

  Response.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    image = json['image'];
    fullName = json['fullName'];
    totalCapital = json['totalCapital'];
    closingPayment = json['closingPayment'];
    lastAmountAdded = json['lastAmountAdded'];
    lastAmountDate = json['lastAmountDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userType'] = this.userType;
    data['image'] = this.image;
    data['fullName'] = this.fullName;
    data['totalCapital'] = this.totalCapital;
    data['closingPayment'] = this.closingPayment;
    data['lastAmountAdded'] = this.lastAmountAdded;
    data['lastAmountDate'] = this.lastAmountDate;
    return data;
  }
}

class UserLoginDataModel {
  UserLoginDataModel({
    this.userInfo,
    required this.token,
    this.skipOtp,
  });

  UserInfoModel? userInfo;
  String token;
  bool? skipOtp;

  factory UserLoginDataModel.fromJson(Map<String, dynamic> json) => UserLoginDataModel(
        //userInfo: UserInfo.fromJson(json["userInfo"]),
        token: json["Token"],
        skipOtp: json["SkipOtp"] == null ? null : json["SkipOtp"],
      );

  Map<String, dynamic> toJson() => {
        "Token": token,
        "SkipOtp": skipOtp == null ? null : skipOtp,
      };
}

class LoginFormDataModel {
  LoginFormDataModel({this.email = "", this.password = "", this.Version
      /*this.rememberMe*/
      });

  String email = "";
  String password = "";
  //bool? rememberMe;
  String? Version;

  factory LoginFormDataModel.fromJson(Map<String, dynamic> json) => LoginFormDataModel(
      email: json["Email"], password: json["Password"], Version: json["Version"]
      //rememberMe: json["RememberMe"] == null ? false : json["RememberMe"],
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "Password": password,
        "Version": Version
        //"RememberMe": rememberMe,
      };
}

class SendOtpData {
  SendOtpData({this.OtpMethod = ""});

  String OtpMethod;

  factory SendOtpData.fromJson(Map<String, dynamic> json) =>
      SendOtpData(OtpMethod: json["OtpMethod"]);

  Map<String, dynamic> toJson() => {"OtpMethod": OtpMethod};
}

class VerifyOtpData {
  VerifyOtpData({this.Token = "", this.Type = ""});

  String Type;
  String Token;

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) =>
      VerifyOtpData(Token: json["Token"], Type: json["Type"]);

  Map<String, dynamic> toJson() => {"Type": Type, "Token": Token};
}