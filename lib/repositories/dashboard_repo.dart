import 'dart:convert';

import 'package:malikopal/model/ClosingRatioResponse_model.dart';
import 'package:malikopal/model/DashboardResponse_model.dart';
import 'package:malikopal/model/GalleryResponse_model.dart';
import 'package:malikopal/model/MessageHistoryResponse_model.dart';
import 'package:malikopal/model/PaymentDetailResponse_model.dart';
import 'package:malikopal/model/ReceivedAmountResponse_model.dart';
import 'package:malikopal/model/ReferenceInResponse_model.dart';
import 'package:malikopal/model/SendNotificationResponse_model.dart';
import 'package:malikopal/model/ClosingPaymentResponse_model.dart';
import 'package:malikopal/model/UpdateBankResponse_model.dart';
import 'package:malikopal/model/UpdateProfileResponse_model.dart';
import 'package:malikopal/model/WithdrawResponse_model.dart';
import 'package:malikopal/model/requestbody/HistoryReqBody_model.dart';

import 'package:malikopal/model/requestbody/PaymentHistoryReqBody_model.dart';
import 'package:malikopal/model/requestbody/ReceivePaymentReqBody_model.dart';
import 'package:malikopal/model/requestbody/ReceivedAmountReqBody_model.dart';
import 'package:malikopal/model/requestbody/SaveMessageReqBody_model.dart';
import 'package:malikopal/model/requestbody/UpdateBankReqBody_model.dart';
import 'package:malikopal/model/requestbody/UpdateProfileReqBody_model.dart';
import 'package:malikopal/model/requestbody/WithdrawReqBody_model.dart';
import 'package:malikopal/model/rollerover_status_model.dart';
import 'package:malikopal/model/tranfer_rolll_over_model.dart';
import 'package:malikopal/model/widthfrawdata_model.dart';
import 'package:malikopal/networking/ApiBaseHelper.dart';
import 'package:malikopal/networking/Endpoints.dart';
import 'package:malikopal/repositories/base_repo.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/autorollerover/model/auto_roller_list_model.dart';
import 'package:malikopal/screens/setting/subreference/reference_user.dart';
import 'package:malikopal/screens/setting/subreference/sub_reference_user_model.dart';
import '../model/capital_history_responce_model.dart';
import '../model/last_deposit_data_model.dart';
import '../screens/setting/subreference/sub_reference_model.dart';
import '../screens/setting/subreference/sub_reference_post.dart';

class DashboardRepository extends BaseRepo {
  static final DashboardRepository _singleton = DashboardRepository._internal();

  factory DashboardRepository() {
    return _singleton;
  }

  DashboardRepository._internal();
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DashboardResponseModel> GetDashboardData() async {
    final response = await _helper.get(Endpoints.DashboardDataUrl);
    return DashboardResponseModel.fromJson(response);
  }

  Future<WithdrawResponseModel> GetWithdrawalData() async {
    //

    final response = await _helper.get(Endpoints.WithdrawDataUrl);

    return WithdrawResponseModel.fromJson(response);
  }

  Future<WithdrawResponseModel> SaveWithdrawalData(WithdrawReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.SaveWithDrawUrl, reqBody);
    var resp = WithdrawResponseModel.fromJson(response);
    return resp;
  }

  Future<WithdrawResponseModel> getWidthDrawData(var reqBody) async {
    final response = await _helper.post(Endpoints.SaveWithDrawUrl, reqBody);

    var resp = WithdrawResponseModel.fromJson(response);
    return resp;
  }

  Future<WidthDrawStatusModel?> getWidrawStatus() async {
    final response = await _helper.getNew(Endpoints.widthdrawget);

    dp(msg: "Status data", arg: response.runtimeType);

    var resp = widthDrawStatusModelFromJson(response);
    print(resp.data?.withdrawRequest?.requestDate);
    return resp;
  }

  Future<AutoRollerOverListModel?> getAutoRollerOver() async {
    final response = await _helper.getNew(Endpoints.autoRollerOver);

    dp(msg: "Status data", arg: response.runtimeType);

    var resp = autoRollerOverListModelFromJson(response);

    return resp;
  }

  Future<Map<String, dynamic>> sendOtp(String userId) async {
    final response = await _helper.postNew(Endpoints.sendOtp + userId, {});

    dp(msg: "Status data", arg: response.runtimeType);
    var dresp = jsonDecode(response);

    return {"status": dresp['Status'], "message": dresp['Mesage']};
  }

  Future<Map<String, dynamic>> resetPassword(
      String userId, String otp, String password) async {
    final response = await _helper.postNew(
        Endpoints.verifyPassword +
            userId +
            "&Code=" +
            otp +
            "&Password=" +
            password,
        {});

    dp(msg: "Status data", arg: response.runtimeType);
    var dresp = jsonDecode(response);

    return {"status": dresp['Status'], "message": dresp['Mesage']};
  }

  Future<SubRefenceModel?> getSubRefence(SubRefencePostData data) async {
    //

    final response =
        await _helper.postNew(Endpoints.subRefenceApi, data.toJson());

    dp(msg: "Status data", arg: response.runtimeType);

    // return SubRefenceModel.fromJson(subRefeMap);
    // ;

    if (response != null) {
      var resp = subRefenceModelFromJson(response);

      return resp;
    } else {
      return null;
    }
  }

  Future<SubRefenceUserData?> getSubRefenceSub(SubRefencePostData data) async {
    //

    final response =
        await _helper.postNew(Endpoints.subRefenceApi, data.toJson());

    // dp(msg: "Status data", arg: response.runtimeType);

    // return SubRefenceUserData.fromJson(subRefenceUserFake);
    // ;

    if (response != null) {
      var resp = subRefenceUserDataFromJson(response);
      dp(msg: "Decode data", arg: resp.data?.toJson());
      return resp;
    } else {
      return null;
    }
  }

  Future<RefrenceInUserModel?> getSubUserRefence(SubRefencePostData data) async {
    //

    final response =
        await _helper.postNew(Endpoints.subRefenceUseranyApi, data.toJson());

    // dp(msg: "Status data", arg: response.runtimeType);

    // return SubRefenceUserData.fromJson(subRefenceUserFake);
    // ;

    if (response != null) {
      var resp = refrenceInUserModelFromJson(response);
      dp(msg: "Decode data", arg: resp.data?.toJson());
      return resp;
    } else {
      return null;
    }
  }

  var subRefenceUserFake = {
    "Data": {
      "ShowList": false,
      "ShowData": false,
      "MemberCount": 1.0,
      "TotalCapital": 1200000.0,
      "TotalClosing": 0.0,
      "ReferenceNodes": [
        {
          "ProfileID": 589,
          "UserID": "100023",
          "FullName": "Toqeer",
          "UserCapitalAmount": 1200000.0,
          "Allow": false,
          "AccountType": "Member",
          "ACD": "2021-04-11T00:00:00",
          "MemberCount": 0,
          "MemberCapital": 0.0,
          "PlusMemberCount": 0,
          "PlusMemberCapital": 0.0,
          "ReferenceUserID": "100362",
          "DirectReferenceUserID": "100614",
          "RecentClosingAmount": 121200.0
        }
      ]
    },
    "Message": null,
    "ErrorList": []
  };

  var subRefeMap = {
    "Data": {
      "ShowList": false,
      "ShowData": false,
      "MemberCount": 1.0,
      "TotalCapital": 715000.0,
      "TotalClosing": 0.0,
      "ReferenceNodes": [
        {
          "ProfileID": 615,
          "UserID": "100614",
          "FullName": "ZOHAIB AHMAD",
          "UserCapitalAmount": 715000.0,
          "Allow": true,
          "AccountType": "Plus",
          "ACD": "2022-05-28T00:00:00",
          "MemberCount": 1,
          "MemberCapital": 0.0,
          "PlusMemberCount": 0,
          "PlusMemberCapital": 0.0,
          "ReferenceUserID": "100362",
          "DirectReferenceUserID": null,
          "RecentClosingAmount": 57772.0
        }
      ]
    },
    "Message": null,
    "ErrorList": []
  };

  Future<UpdateProfileResponseModel> GetProfileData() async {
    final response = await _helper.get(Endpoints.ProfileDataUrl);
    return UpdateProfileResponseModel.fromJson(response);
  }

  Future<UpdateProfileResponseModel> GetProfileViewData(int profileid) async {
    final response = await _helper.get(
        Endpoints.ProfileViewDataUrl + "?profileId=" + profileid.toString());
    return UpdateProfileResponseModel.fromJson(response);
  }

  Future<UpdateProfileResponseModel> SaveProfileData(
      UpdateProfileReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.SaveProfileUrl, reqBody);
    var resp = UpdateProfileResponseModel.fromJson(response);
    return resp;
  }

  Future<dynamic> SaveProfilePicture(String path) async {
    final response = await _helper.postProfilePic(Endpoints.uploadPicUrl, path);
    return response;
  }

  Future<UpdateBankResponseModel> GetBankData() async {
    final response = await _helper.get(Endpoints.BankDataUrl);
    return UpdateBankResponseModel.fromJson(response);
  }

  Future<UpdateBankResponseModel> SaveBankData(UpdateBankReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.SaveBankUrl, reqBody);
    var resp = UpdateBankResponseModel.fromJson(response);
    return resp;
  }

  Future<TransferRolloverModel> getTransferData() async {
    final response = await _helper.getNew(Endpoints.transferdata);
    print(response);
    return transferRolloverModelFromJson(response);
  }

  Future<ClosingPaymentResponseModel> GetPaymentRolloverData() async {
    final response = await _helper.get(Endpoints.PaymentRolloverDataUrl);
    return ClosingPaymentResponseModel.fromJson(response);
  }

  Future<RollerOverStatusModel> getRollerOverStatus() async {
    final response = await _helper.getNew(Endpoints.rollerOverStatus);
    return rollerOverStatusModelFromJson(response);
  }

  Future<TransferRolloverModel> SavePaymentRolloverNew(
      ReceivePaymentReqBodyModel reqBody) async {
    final response =
        await _helper.postNew("dashboard/transferrollover-post", reqBody);
    var resp = transferRolloverModelFromJson(response);
    return resp;
  }

  Future<WidthDrawStatusModel> withDrawPOst(WithdrawReqBodyModel reqBody) async {
    final response = await _helper.postNew("dashboard/withdraw-post", reqBody);
    var resp = widthDrawStatusModelFromJson(response);
    return resp;
  }

  Future<RollerOverStatusModel> SavePaymentRolloverAll(
      ReceivePaymentReqBodyModel reqBody) async {
    final response =
        await _helper.postNew("dashboard/allrollover-post", reqBody);
    var resp = rollerOverStatusModelFromJson(response);
    return resp;
  }

  Future<ClosingPaymentResponseModel> SavePaymentRollover(
      ReceivePaymentReqBodyModel reqBody) async {
    final response =
        await _helper.post(Endpoints.SavePaymeyRolloverUrl, reqBody);
    var resp = ClosingPaymentResponseModel.fromJson(response);
    return resp;
  }

  Future<ClosingPaymentResponseModel> closingPaymentRequest(
      ReceivePaymentReqBodyModel reqBody) async {
    final response =
        await _helper.post(Endpoints.SavePaymeyRolloverUrl, reqBody);
    var resp = ClosingPaymentResponseModel.fromJson(response);
    return resp;
  }

  Future<ClosingPaymentResponseModel> SaveRollover(
      ReceivePaymentReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.SaveRolloverUrl, reqBody);
    var resp = ClosingPaymentResponseModel.fromJson(response);
    return resp;
  }

  Future<ClosingRatioResponseModel> GetClosingRatioData() async {
    final response = await _helper.get(Endpoints.RatioUrl);
    return ClosingRatioResponseModel.fromJson(response);
  }

  Future<PaymentRolloverHistoryResponseModel> GetPaymentRolloveHistoryData(
      PaymentHistoryReqBodyModel reqBody) async {
    final response =
        await _helper.post(Endpoints.PaymentRolloverHistoryUrl, reqBody);
    return PaymentRolloverHistoryResponseModel.fromJson(response);
  }

  // Future<CapitalHistoryResponse> GetCapitalHistoryData() async {
  //   final response = await _helper.get(Endpoints.CapitalHistoryRequestGet);
  //   return CapitalHistoryResponse.fromJson(response);
  // }

  Future<CapitalHistoryResponseModel> GetCapitalHistoryData(
      HistoryReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.CapitalHistoryUrl, reqBody);
    dp(msg: "Capital type", arg: response.runtimeType);
    dp(msg: "Capital data", arg: response);
    var resp = CapitalHistoryResponseModel.fromJson(response);
    dp(msg: "Capital history responce", arg: resp.toJson());
    return resp;
  }
  //GetLastAddedAmountyData

  Future<CapitalHistoryResponseModel> GetLastAddedAmountyData(
      HistoryReqBodyModel reqBody) async {
    final response =
        await _helper.post(Endpoints.LastAddAmountHistoryUrl, reqBody);

    dp(msg: "Last deposit", arg: response);

    var resp = CapitalHistoryResponseModel.fromJson(response);
    return resp;
  }

  Future<NewCapitalHistoryResponseModel?> GetLastAddedAmountyDataNew(
      HistoryReqBodyModel reqBody) async {
    final response =
        await _helper.post(Endpoints.LastAddAmountHistoryUrl, reqBody);

    dp(msg: "Last deposit", arg: response);

    var resp = NewCapitalHistoryResponseModel.fromJson(response);
    return resp;
  }

  Future<ReceivedAmountResponseModel> GetReceivedAmount(
      ReceivedAmountReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.ReceivedAmountUrl, reqBody);
    var resp = ReceivedAmountResponseModel.fromJson(response);
    return resp;
  }

  Future<SendNotificationResponseModel> GetNotificationData() async {
    final response = await _helper.get(Endpoints.NotificationUrl);
    return SendNotificationResponseModel.fromJson(response);
  }

  Future<RefrenceInResponseDataModel> PostReferenceInData(
      HistoryReqBodyModel reqBody, String? query) async {
    final response = await _helper.post(Endpoints.SaveReferenceInUrl, reqBody);
    var resp = RefrenceInResponseDataModel.fromJson(response);
    return resp;
  }

  Future<MessageHistoryResponseModel> GetMessageHistoryData() async {
    final response = await _helper.get(Endpoints.MessageHistoryUrl);
    return MessageHistoryResponseModel.fromJson(response);
  }

  Future<MessageHistoryResponseModel> SaveMessageData(
      SaveMessageReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.SaveMessageUrl, reqBody);
    var resp = MessageHistoryResponseModel.fromJson(response);
    return resp;
  }

  Future<GalleryResponseModel> GetGalleryData() async {
    final response = await _helper.get(Endpoints.galleryUrl);
    return GalleryResponseModel.fromJson(response);
  }

//https://localhost:44321/api/dashboard/auto-rollover-post
  Future<AutoRollerOverListModel?> postAutoRollOver(int id) async {
    try {
      var responce =
          await _helper.postNew(Endpoints.postAutoRollover, {"Data": id});
      return autoRollerOverListModelFromJson(responce);
    } catch (e, s) {
      dp(msg: "Error $e", arg: s);
      return null;
    }
  }
}
