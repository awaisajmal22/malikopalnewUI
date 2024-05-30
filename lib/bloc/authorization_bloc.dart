import 'dart:async';

import 'package:malikopal/bloc/dispose_bloc.dart';
import 'package:malikopal/model/auth_model/LoginResponse_model.dart';
import 'package:malikopal/model/auth_model/SendOtpResponse_model.dart';
import 'package:malikopal/model/auth_model/VerifyOtpResponse_model.dart';
import 'package:malikopal/model/requestbody/ChangePasswordReqBody_model.dart';
import 'package:malikopal/model/requestbody/SendOtpReqBody_model.dart';
import 'package:malikopal/model/requestbody/ThumbReqBody_model.dart';
import 'package:malikopal/model/requestbody/UserLoginReqBody_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/model/auth_model/LoginData_model.dart';
import 'package:malikopal/utils/Const.dart';


class AuthorizationBloc implements DisposeBloc {
  //

  AuthRepository _repository = AuthRepository();

   late StreamController<ApiResponse<UserLoginDataModel>> _scPostLogin;
  late StreamController<ApiResponse<SendOtpResponseDataModel>> _scSendOtp;
  late StreamController<ApiResponse<VerifyOtpResponseDataModel>> _scVerifyOtp;
  late StreamController<ApiResponse<ChangePasswordReqDataModel>> _scPassChangePost;
  late StreamController<ApiResponse<UserLoginDataModel>> _scActivateThumb;
  late StreamController<ApiResponse<UserLoginDataModel>> _scLoginByThumb;

  StreamSink<ApiResponse<UserLoginDataModel>> get loginResponseSink =>
      _scPostLogin.sink;
  Stream<ApiResponse<UserLoginDataModel>> get loginResponseStream =>
      _scPostLogin.stream;

  StreamSink<ApiResponse<SendOtpResponseDataModel>> get sendOtpDataSink =>
      _scSendOtp.sink;
  Stream<ApiResponse<SendOtpResponseDataModel>> get sendOtopDateStream =>
      _scSendOtp.stream;

  StreamSink<ApiResponse<VerifyOtpResponseDataModel>> get verifyOtpSink =>
      _scVerifyOtp.sink;
  Stream<ApiResponse<VerifyOtpResponseDataModel>> get verifyOtpStream =>
      _scVerifyOtp.stream;

  StreamSink<ApiResponse<ChangePasswordReqDataModel>> get passChangeSink =>
      _scPassChangePost.sink;
  Stream<ApiResponse<ChangePasswordReqDataModel>> get passChangeStream =>
      _scPassChangePost.stream;

  StreamSink<ApiResponse<UserLoginDataModel>> get ActivateThumbSink =>
      _scActivateThumb.sink;
  Stream<ApiResponse<UserLoginDataModel>> get ActivateThumbStream =>
      _scActivateThumb.stream;

  StreamSink<ApiResponse<UserLoginDataModel>> get LoginByThumbSink =>
      _scLoginByThumb.sink;
  Stream<ApiResponse<UserLoginDataModel>> get LoginByThumbStream =>
      _scLoginByThumb.stream;

  AuthorizationBloc() {
    _scPostLogin = StreamController<ApiResponse<UserLoginDataModel>>();
    _scSendOtp = StreamController<ApiResponse<SendOtpResponseDataModel>>();
    _scVerifyOtp = StreamController<ApiResponse<VerifyOtpResponseDataModel>>();
    _scPassChangePost = StreamController<ApiResponse<ChangePasswordReqDataModel>>();
    _scActivateThumb = StreamController<ApiResponse<UserLoginDataModel>>();
    _scLoginByThumb = StreamController<ApiResponse<UserLoginDataModel>>();
    _repository = AuthRepository();
  }

  postLoginFormData(LoginFormDataModel data) async {
    UserLoginReqBodyModel reqBody = UserLoginReqBodyModel(data: data);

    loginResponseSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));

    try {
      UserLoginResponseModel response = await _repository.postLoginFormData(reqBody);
      loginResponseSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      loginResponseSink.add(
          ApiResponse.error("User name or password is empty please try again"));
      print(e.toString());
    }
  }

  postSendOtp(SendOtpData data) async {
    SendOtpReqBodyModel reqBody = SendOtpReqBodyModel(data: data);
    sendOtpDataSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      var response = await _repository.postSendOtpData(reqBody);
      sendOtpDataSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      sendOtpDataSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  postVerifyOtp(VerifyOtpData data) async {
    VerifyOtpReqBodyModel reqBody = VerifyOtpReqBodyModel(data: data);
    verifyOtpSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      var response = await _repository.postVerifyOtpData(reqBody);
      verifyOtpSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      verifyOtpSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  SaveChangePassword(ChangePasswordReqDataModel data) async {
    ChangePasswordReqBodyModel reqBody = ChangePasswordReqBodyModel(data: data);
    passChangeSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      var response = await _repository.postChangePassword(reqBody);
      passChangeSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      passChangeSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  ActivateThumbLogin(ThumbReqDataModel data) async {
    ThumbReqBodyModel reqBody = ThumbReqBodyModel(data: data);
    ActivateThumbSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));
    try {
      var response = await _repository.ActivateThumb(reqBody);
      ActivateThumbSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      ActivateThumbSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  ThumbLogin(ThumbReqDataModel data) async {
    ThumbReqBodyModel reqBody = ThumbReqBodyModel(data: data);

    LoginByThumbSink.add(ApiResponse.loading(Constant.COMMON_PLEASE_WAIT));

    try {
      UserLoginResponseModel response = await _repository.LoginByThumb(reqBody);
      LoginByThumbSink.add(ApiResponse.completed(response.data));
    } catch (e) {
      LoginByThumbSink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _scPostLogin.close();
    _scSendOtp.close();
    _scVerifyOtp.close();
  }
}
