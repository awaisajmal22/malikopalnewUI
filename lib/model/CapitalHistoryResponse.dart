// class CapitalHistoryResponse {
//   CapitalHistoryResponse({
//     required this.data,
//     required this.message,
//     required this.errorList,
//   });

//   List<CapitalHistoryResponseData>? data;
//   late String message;
//   late List<String> errorList;
//   factory CapitalHistoryResponse.fromJson(Map<String, dynamic> json) =>
//       CapitalHistoryResponse(
//         data: json["Data"] == null
//             ? null
//             : List<CapitalHistoryResponseData>.from(json["Data"]
//                 .map((x) => CapitalHistoryResponseData.fromJson(x))),
//         message: json["Message"] == null ? "" : json["Message"],
//         errorList: List<String>.from(json["ErrorList"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         //"Data": data.toJson(),
//         "Message": message,
//         "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
//       };
// }

// class CapitalHistoryResponseData {
//   num? ID;
//   String? Date;
//   String? DateStr;
//   String? Type;
//   String? ClosingMonth;
//   String? Desc;
 
//   FnfDetailsData? fnfDetailsData;

//   CapitalHistoryResponseData(
//       {this.ID,
//       this.Date,
//       this.DateStr,
//       this.Type,
//       this.ClosingMonth,
//       this.Desc,
//       this.Debit,
//       this.Credit,
//       this.Balance,
//       this.TotalCapitalAmount,
//       this.fnfDetailsData});

//   CapitalHistoryResponseData.fromJson(Map<String, dynamic> json) {
//     Balance = json['Balance'];
//     ClosingMonth = json['ClosingMonth'];
//     TotalCapitalAmount = json['TotalCapitalAmount'];
//     Credit = json['Credit'];
//     Date = json['Date'];
//     DateStr = json['DateStr'];
//     Debit = json['Debit'];
//     Desc = json['Desc'];
//     ID = json['ID'];
//     Type = json['Type'];
//     fnfDetailsData = json['FnFDetails'] != null
//         ? FnfDetailsData.fromJson(json['FnFDetails'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Balance'] = this.Balance;
//     data['TotalCapitalAmount'] = this.TotalCapitalAmount;
//     data['ClosingMonth'] = this.ClosingMonth;
//     data['Credit'] = this.Credit;
//     data['Date'] = this.Date;
//     data['DateStr'] = this.DateStr;
//     data['Debit'] = this.Debit;
//     data['Desc'] = this.Desc;
//     data['ID'] = this.ID;
//     data['Type'] = this.Type;
//     if (this.fnfDetailsData != null) {
//       data['FnFDetails'] = this.fnfDetailsData!.toJson();
//     }
//     return data;
//   }
// }


