import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:malikopal/model/requestbody/HistoryReqBody_model.dart';
import 'package:mime/mime.dart';
import 'package:malikopal/bloc/dispose_bloc.dart';
import 'package:malikopal/model/CapitalHistoryResponse.dart';
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
import 'package:malikopal/model/requestbody/PaymentHistoryReqBody_model.dart';
import 'package:malikopal/model/requestbody/ProfilePicReqBody_model.dart';
import 'package:malikopal/model/requestbody/ReceivePaymentReqBody_model.dart';
import 'package:malikopal/model/requestbody/ReceivedAmountReqBody_model.dart';
import 'package:malikopal/model/requestbody/SaveMessageReqBody_model.dart';
import 'package:malikopal/model/requestbody/UpdateBankReqBody_model.dart';
import 'package:malikopal/model/requestbody/UpdateProfileReqBody_model.dart';
import 'package:malikopal/model/requestbody/WithdrawReqBody_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/repositories/dashboard_repo.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/utils/Const.dart';

import '../model/capital_history_responce_model.dart';
import '../model/widthfrawdata_model.dart';

class DashBoardBloc implements DisposeBloc {
  DashboardRepository _repository = DashboardRepository();

  late StreamController<ApiResponse<DashboardResponseDataModel>>
      _scDashboarData;

  StreamSink<ApiResponse<DashboardResponseDataModel>>
      get dashboardResponseSink => _scDashboarData.sink;
  Stream<ApiResponse<DashboardResponseDataModel>> get dashboardResponseStream =>
      _scDashboarData.stream;

//   -----withdraw
  late StreamController<ApiResponse<WidthDrawStatusModel>> _scWithdrawgetData;

  StreamSink<ApiResponse<WidthDrawStatusModel>> get WithdrawResponsegetSink =>
      _scWithdrawgetData.sink;
  Stream<ApiResponse<WidthDrawStatusModel>> get WithdrawResponsegetStream =>
      _scWithdrawgetData.stream;

  late StreamController<ApiResponse<WidthDrawStatusModel>> _scWithdrawpostData;

  StreamSink<ApiResponse<WidthDrawStatusModel>> get WithdrawResponsepostSink =>
      _scWithdrawpostData.sink;
  Stream<ApiResponse<WidthDrawStatusModel>> get WithdrawResponsepostStream =>
      _scWithdrawpostData.stream;

//   ------ Update Profile

  late StreamController<ApiResponse<UpdateProfileResponseDataModel>>
      _scProfilegetData;

  StreamSink<ApiResponse<UpdateProfileResponseDataModel>>
      get UpdateProfileResponsegetSink => _scProfilegetData.sink;
  Stream<ApiResponse<UpdateProfileResponseDataModel>>
      get UpdateProfileResponsegetStream => _scProfilegetData.stream;

  late StreamController<ApiResponse<UpdateProfileResponseDataModel>>
      _scUpdateProfilepostData;

  StreamSink<ApiResponse<UpdateProfileResponseDataModel>>
      get UpdateProfileResponsepostSink => _scUpdateProfilepostData.sink;
  Stream<ApiResponse<UpdateProfileResponseDataModel>>
      get UpdateProfileResponsepostStream => _scUpdateProfilepostData.stream;

//  -----Update Bank Controllers

  late StreamController<ApiResponse<UpdateBankResponseDataModel>>
      _scBankgetData;

  StreamSink<ApiResponse<UpdateBankResponseDataModel>> get GetBankDataSink =>
      _scBankgetData.sink;
  Stream<ApiResponse<UpdateBankResponseDataModel>> get GetBankDataStream =>
      _scBankgetData.stream;

  late StreamController<ApiResponse<UpdateBankResponseDataModel>>
      _scSaveBankData;

  StreamSink<ApiResponse<UpdateBankResponseDataModel>> get SaveBankDataSink =>
      _scSaveBankData.sink;
  Stream<ApiResponse<UpdateBankResponseDataModel>> get SaveBankDataStream =>
      _scSaveBankData.stream;

  //  -----send Payment Controllers

  late StreamController<ApiResponse<ClosingPaymentResponseDataModel>>
      _scGetPaymentRolloverData;

  StreamSink<ApiResponse<ClosingPaymentResponseDataModel>>
      get GetPaymentRolloverSink => _scGetPaymentRolloverData.sink;
  Stream<ApiResponse<ClosingPaymentResponseDataModel>>
      get GetPaymentRolloverStream => _scGetPaymentRolloverData.stream;

  late StreamController<ApiResponse<ClosingPaymentResponseDataModel>>
      _scSavePaymentRolloverData;

  StreamSink<ApiResponse<ClosingPaymentResponseDataModel>>
      get SavePaymentRolloverSink => _scSavePaymentRolloverData.sink;
  Stream<ApiResponse<ClosingPaymentResponseDataModel>>
      get SavePaymentRolloverStream => _scSavePaymentRolloverData.stream;

  //  -----Closing Ratio Controllers
  late StreamController<ApiResponse<ClosingRatioResponseDataModel>>
      _scClosingRatiogetData;

  StreamSink<ApiResponse<ClosingRatioResponseDataModel>>
      get GetClosingRatioSink => _scClosingRatiogetData.sink;
  Stream<ApiResponse<ClosingRatioResponseDataModel>>
      get GetClosingRatioStream => _scClosingRatiogetData.stream;

  //------------- Payment Detail Controller

  late StreamController<
          ApiResponse<List<PaymentRolloverHistoryResponseDataModel>>>
      _scPaymentRolloverHistoryData;

  StreamSink<ApiResponse<List<PaymentRolloverHistoryResponseDataModel>>>
      get PaymentRolloverHistorySink => _scPaymentRolloverHistoryData.sink;
  Stream<ApiResponse<List<PaymentRolloverHistoryResponseDataModel>>>
      get PaymentRolloverHistoryStream => _scPaymentRolloverHistoryData.stream;

  //------------- Send Notification Detail Controller

  late StreamController<ApiResponse<List<SendNotificationResponseDataModel>>>
      _scNotificationtData;

  StreamSink<ApiResponse<List<SendNotificationResponseDataModel>>>
      get GetNotificationSink => _scNotificationtData.sink;
  Stream<ApiResponse<List<SendNotificationResponseDataModel>>>
      get GetNotificationStream => _scNotificationtData.stream;

  //------------- History Data Post Controller

  late StreamController<ApiResponse<CapitalHistoryResponseDataModel>>
      _scCapitalHistoryData;

  StreamSink<ApiResponse<CapitalHistoryResponseDataModel>>
      get CapitalHistorySink => _scCapitalHistoryData.sink;
  Stream<ApiResponse<CapitalHistoryResponseDataModel>>
      get CapitalHistoryStream => _scCapitalHistoryData.stream;

  //  ----------------Capital History  Controller

  late StreamController<ApiResponse<ReceivedAmountResponseDataModel>>
      _scReceivedAmountData;

  StreamSink<ApiResponse<ReceivedAmountResponseDataModel>>
      get ReceivedAmountSink => _scReceivedAmountData.sink;
  Stream<ApiResponse<ReceivedAmountResponseDataModel>>
      get ReceivedAmountStream => _scReceivedAmountData.stream;

  //------------Reference in

  late StreamController<ApiResponse<RefrenceInResponseDataModel>>
      _scReferenceInData;

  StreamSink<ApiResponse<RefrenceInResponseDataModel>> get GetReferenceInSink =>
      _scReferenceInData.sink;
  Stream<ApiResponse<RefrenceInResponseDataModel>> get GetReferenceInStream =>
      _scReferenceInData.stream;

  //------------ Message History Load

  late StreamController<ApiResponse<List<MessageHistoryResponseDataModel>>>
      _scMessageHistoryData;

  StreamSink<ApiResponse<List<MessageHistoryResponseDataModel>>>
      get GetMessageHistorySink => _scMessageHistoryData.sink;
  Stream<ApiResponse<List<MessageHistoryResponseDataModel>>>
      get GetMessageHistoryStream => _scMessageHistoryData.stream;

  //------------Save Message

  late StreamController<ApiResponse<List<MessageHistoryResponseDataModel>>>
      _scSaveMessageData;

  StreamSink<ApiResponse<List<MessageHistoryResponseDataModel>>>
      get SaveMessageSink => _scSaveMessageData.sink;
  Stream<ApiResponse<List<MessageHistoryResponseDataModel>>> get SaveMessageStream =>
      _scSaveMessageData.stream;

  //------------Save Profile Pic

  late StreamController<ApiResponse<dynamic>> _scSavePicData;

  StreamSink<ApiResponse<dynamic>> get SavePicSink => _scSavePicData.sink;
  Stream<ApiResponse<dynamic>> get SavePicStream => _scSavePicData.stream;

  late StreamController<ApiResponse<List<GalleryResponseDataModel>>> _scGalleryData;

  StreamSink<ApiResponse<List<GalleryResponseDataModel>>> get GallerySink =>
      _scGalleryData.sink;
  Stream<ApiResponse<List<GalleryResponseDataModel>>> get GalleryStream =>
      _scGalleryData.stream;
  //---------------------------------Initialization End

  DashBoardBloc() {
    _scDashboarData = StreamController<ApiResponse<DashboardResponseDataModel>>();
    _scWithdrawgetData = StreamController<ApiResponse<WidthDrawStatusModel>>();
    _scWithdrawpostData = StreamController<ApiResponse<WidthDrawStatusModel>>();
    _scProfilegetData =
        StreamController<ApiResponse<UpdateProfileResponseDataModel>>();
    _scUpdateProfilepostData =
        StreamController<ApiResponse<UpdateProfileResponseDataModel>>();
    _scBankgetData = StreamController<ApiResponse<UpdateBankResponseDataModel>>();
    _scSaveBankData = StreamController<ApiResponse<UpdateBankResponseDataModel>>();
    _scGetPaymentRolloverData =
        StreamController<ApiResponse<ClosingPaymentResponseDataModel>>();
    _scSavePaymentRolloverData =
        StreamController<ApiResponse<ClosingPaymentResponseDataModel>>();
    _scClosingRatiogetData =
        StreamController<ApiResponse<ClosingRatioResponseDataModel>>();
    _scPaymentRolloverHistoryData = StreamController<
        ApiResponse<List<PaymentRolloverHistoryResponseDataModel>>>.broadcast();
    _scNotificationtData =
        StreamController<ApiResponse<List<SendNotificationResponseDataModel>>>();
    _scCapitalHistoryData = StreamController<
        ApiResponse<CapitalHistoryResponseDataModel>>.broadcast();
    _scReceivedAmountData =
        StreamController<ApiResponse<ReceivedAmountResponseDataModel>>();
    _scReferenceInData =
        StreamController<ApiResponse<RefrenceInResponseDataModel>>.broadcast();
    _scMessageHistoryData = StreamController<
        ApiResponse<List<MessageHistoryResponseDataModel>>>.broadcast();
    _scSaveMessageData = StreamController<
        ApiResponse<List<MessageHistoryResponseDataModel>>>.broadcast();
    _scGalleryData =
        StreamController<ApiResponse<List<GalleryResponseDataModel>>>.broadcast();
    _repository = DashboardRepository();

    _scSavePicData = StreamController<ApiResponse<dynamic>>();
  }

  getDashboardData() async {
    dashboardResponseSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));

    try {
      DashboardResponseModel response = await _repository.GetDashboardData();
      dashboardResponseSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      dashboardResponseSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  getWithdrawData() async {
    WithdrawResponsegetSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      // WidthDrawStatus response = await _repository.getWidrawStatus();

      // dp(msg: "Widgth draw data", arg: response.toJson());
      // WithdrawResponsegetSink.add(ApiResponse.completed(response));
    } catch (e) {
      WithdrawResponsegetSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  getWithDrawData() async {
    WithdrawResponsepostSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    // var response = await _repository.SaveWithdrawalData( );
  }

  SaveWithdrawalData(WithdrawReqDataModel data) async {
    WithdrawResponsepostSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    WithdrawReqBodyModel reqBody = WithdrawReqBodyModel(data: data);
    try {
      WithdrawResponseModel response = await _repository.SaveWithdrawalData(reqBody);
      // WithdrawResponsepostSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      WithdrawResponsepostSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ update Profile methods

  GetProfileData() async {
    UpdateProfileResponsegetSink.add(
        ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      UpdateProfileResponseModel response = await _repository.GetProfileData();
      UpdateProfileResponsegetSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      UpdateProfileResponsegetSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  GetProfileViewData(int profileid) async {
    UpdateProfileResponsegetSink.add(
        ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      UpdateProfileResponseModel response =
          await _repository.GetProfileViewData(profileid);
      UpdateProfileResponsegetSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      UpdateProfileResponsegetSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  ProfilePicReqDataModel? GetImageData(String filePath) {
    if (filePath == "") return null;
    final publicKey = '';
    final imageType = lookupMimeType(filePath).toString();
    final fileName = filePath.split('/').last;
    final base64Image = base64Encode(File(filePath).readAsBytesSync());
    ProfilePicReqDataModel req = ProfilePicReqDataModel(
        publicKey: publicKey,
        imageType: imageType,
        fileName: fileName,
        base64Image: base64Image);
    return req;
  }

  SaveProfileData(UpdateProfileReqDataModel data, String? image) async {
    UpdateProfileResponsepostSink.add(
        ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));

    UpdateProfileReqBodyModel reqBody = UpdateProfileReqBodyModel(
        data: data, uploadPicture: GetImageData(image ?? ""));
    try {
      UpdateProfileResponseModel response =
          await _repository.SaveProfileData(reqBody);
      UpdateProfileResponsepostSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      UpdateProfileResponsepostSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ update Bank get methods

  GetBankData() async {
    GetBankDataSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      UpdateBankResponseModel response = await _repository.GetBankData();
      GetBankDataSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetBankDataSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }
  //  ------ update Bank POst methods

  SaveBankData(UpdateBankReqDataModel data) async {
    SaveBankDataSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    UpdateBankReqBodyModel reqBody = UpdateBankReqBodyModel(data: data);
    try {
      UpdateBankResponseModel response = await _repository.SaveBankData(reqBody);
      SaveBankDataSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      SaveBankDataSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Send Payment get methods

  GetPaymentRolloverData() async {
    GetPaymentRolloverSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      ClosingPaymentResponseModel response =
          await _repository.GetPaymentRolloverData();
      GetPaymentRolloverSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetPaymentRolloverSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Receive Payment Post methods
  SavePaymentRollover(ReceivePaymentReqDataModel data) async {
    SavePaymentRolloverSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));

    ReceivePaymentReqBodyModel reqBody = ReceivePaymentReqBodyModel(data: data);

    try {
      ClosingPaymentResponseModel response =
          await _repository.SavePaymentRollover(reqBody);
      SavePaymentRolloverSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      SavePaymentRolloverSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Receive Payment Post methods
  SaveRollover(ReceivePaymentReqDataModel data) async {
    SavePaymentRolloverSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    ReceivePaymentReqBodyModel reqBody = ReceivePaymentReqBodyModel(data: data);
    try {
      ClosingPaymentResponseModel response =
          await _repository.SavePaymentRollover(reqBody);
      SavePaymentRolloverSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      SavePaymentRolloverSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }
  //  ------Send Closing Ratio get methods

  GetClosingRatioData() async {
    GetClosingRatioSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      ClosingRatioResponseModel response = await _repository.GetClosingRatioData();
      GetClosingRatioSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetClosingRatioSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Payment Detail get methods

  GetPaymentRolloveHistoryData(PaymentHistoryReqDataModel data) async {
    PaymentRolloverHistorySink.add(
        ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    PaymentHistoryReqBodyModel reqBody =
        new PaymentHistoryReqBodyModel(data: data);
    try {
      PaymentRolloverHistoryResponseModel response =
          await _repository.GetPaymentRolloveHistoryData(reqBody);
      PaymentRolloverHistorySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      PaymentRolloverHistorySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ Notification get methods
  GetNotificationData() async {
    GetNotificationSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      SendNotificationResponseModel response =
          await _repository.GetNotificationData();
      GetNotificationSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetNotificationSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ History Post methods
  GetCapitalHistoryData(HistoryReqDataModel data) async {
    CapitalHistorySink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    HistoryReqBodyModel reqBody = HistoryReqBodyModel(data: data);
    try {
      CapitalHistoryResponseModel response =
          await _repository.GetCapitalHistoryData(reqBody);

      CapitalHistorySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      CapitalHistorySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  GetLastAddedAmountyData(HistoryReqDataModel data) async {
    CapitalHistorySink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    HistoryReqBodyModel reqBody = HistoryReqBodyModel(data: data);
    try {
      CapitalHistoryResponseModel response =
          await _repository.GetLastAddedAmountyData(reqBody);
      CapitalHistorySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      CapitalHistorySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ History Post methods
  GetReceivedAmountData(ReceivedAmountReqDataModel data) async {
    ReceivedAmountSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    ReceivedAmountReqBodyModel reqBody = ReceivedAmountReqBodyModel(data: data);
    try {
      ReceivedAmountResponseModel response =
          await _repository.GetReceivedAmount(reqBody);
      ReceivedAmountSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      ReceivedAmountSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //Reference In Methods
  //  ------Reference In  Post methods
  GetReferenceIn(HistoryReqDataModel data) async {
    GetReferenceInSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    HistoryReqBodyModel reqBody = HistoryReqBodyModel(data: data);
    try {
      RefrenceInResponseDataModel response =
          await _repository.PostReferenceInData(reqBody, "");
      GetReferenceInSink.add(ApiResponse.completed(response));
    } catch (e) {
      GetReferenceInSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Profile Pic  Post methods
  SaveProfilePic(String path) async {
    SavePicSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      dynamic response = await _repository.SaveProfilePicture(path);
      SavePicSink.add(ApiResponse.completed(response));
    } catch (e) {
      SavePicSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------ Notification get methods
  GetMessageHistoryData() async {
    GetMessageHistorySink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      MessageHistoryResponseModel response =
          await _repository.GetMessageHistoryData();
      GetMessageHistorySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GetMessageHistorySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  //  ------Receive Payment Post methods
  SaveMessageData(SaveMessageReqBodyDataModel data) async {
    SaveMessageSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    SaveMessageReqBodyModel reqBody = SaveMessageReqBodyModel(data: data);
    try {
      MessageHistoryResponseModel response =
          await _repository.SaveMessageData(reqBody);
      SaveMessageSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      SaveMessageSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  getGalleryData() async {
    GallerySink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      GalleryResponseModel response = await _repository.GetGalleryData();
      GallerySink.add(ApiResponse.completed(response.data));
    } catch (e) {
      GallerySink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _scDashboarData.close();
  }
}
