import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:malikopal/model/auth_model/ChangePasswordResponse_model.dart';


import 'package:malikopal/model/auth_model/LoginResponse_model.dart';
import 'package:malikopal/model/auth_model/SendOtpResponse_model.dart';
import 'package:malikopal/model/auth_model/VerifyOtpResponse_model.dart';
import 'package:malikopal/model/requestbody/ChangePasswordReqBody_model.dart';
import 'package:malikopal/model/requestbody/SendOtpReqBody_model.dart';
import 'package:malikopal/model/requestbody/ThumbReqBody_model.dart';
import 'package:malikopal/model/requestbody/UserLoginReqBody_model.dart';
import 'package:malikopal/networking/ApiBaseHelper.dart';
import 'package:malikopal/networking/Endpoints.dart';
import 'package:malikopal/repositories/base_repo.dart';

dp({msg, arg}) {
  debugPrint(" ===== $msg   $arg  ====== \n");
}

class AuthRepository extends BaseRepo {
  ApiBaseHelper _helper = ApiBaseHelper();
  static final AuthRepository _AuthRepository = AuthRepository._internal();

  factory AuthRepository() {
    return _AuthRepository;
  }

  AuthRepository._internal();
  Future<UserLoginResponseModel> postLoginFormData(UserLoginReqBodyModel reqBody) async {
    //

    dp(msg: "user login data", arg: reqBody.data!.toJson());

    final response = await _helper.post(Endpoints.LoginUrl, reqBody);

    dp(msg: "Login responce", arg: jsonEncode(response).toString());

    var resp = UserLoginResponseModel.fromJson(response);
    return resp;
  }
  // Future<UserLoginResponse> postLoginFormData(UserLoginReqBody reqBody) async {
  //   final response = await _helper.post(Endpoints.LoginUrl, reqBody);
  //   var resp = UserLoginResponse.fromJson(response);
  //   return resp;
  // }

  Future<SendOtpResponseModel> postSendOtpData(SendOtpReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.OtpUrl, reqBody);
    return SendOtpResponseModel.fromJson(response);
  }

  Future<VerifyOtpResponseModel> postVerifyOtpData(VerifyOtpReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.VerifyOtpUrl, reqBody);
    return VerifyOtpResponseModel.fromJson(response);
  }

  Future<ChangePasswordResponseModel> postChangePassword(
      ChangePasswordReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.ChangePasswordUrl, reqBody);
    return ChangePasswordResponseModel.fromJson(response);
  }

  Future<UserLoginResponseModel> ActivateThumb(ThumbReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.ActivateThumbUrl, reqBody);
    return UserLoginResponseModel.fromJson(response);
  }

  Future<UserLoginResponseModel> LoginByThumb(ThumbReqBodyModel reqBody) async {
    final response = await _helper.post(Endpoints.LoginByThumbUrl, reqBody);
    return UserLoginResponseModel.fromJson(response);
  }
}
