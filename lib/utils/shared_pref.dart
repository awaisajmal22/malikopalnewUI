import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:malikopal/model/DashboardResponse_model.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/services/GlobalService.dart';

class SessionData {
  static const _keyLoggedIn = '_keyLoggedIn';
  static const _keyAuthToken = '_keyAuthToken';
  static const _keyDeviceId = '_keyDeviceId';
  static const _keyDarkTheme = '_keyDarkTheme';
  static const _keyTouchID = '_keyTouchID';
  static const _keyTouchUserName = '_keyTouchUserName';
  static const _keyProfileData = '_keyProfileData';
  static const _keyGlowID = '_keyGlowSetting';
  static const _imageID = '_imagepath';

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAuthToken) ?? "";
  }

  Future<void> clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('_keyLoggedIn');
    await prefs.remove('_keyAuthToken');
    await prefs.remove('_keyCustomerInfo');
    await prefs.remove('_keyTouchID');
    await prefs.remove('_keyGlowSetting');
    await prefs.remove('v');

    GlobalService().setAuthToken("");

    return;
  }

  Future<void> setUserSession(
    String authToken,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, true);
    await prefs.setString(_keyAuthToken, authToken);

    GlobalService().setAuthToken(authToken);

    return; // success
  }

  Future<DashboardResponseDataModel> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String profData = prefs.getString(_keyProfileData) ?? "";
    dp(msg: "get profile", arg: profData);
    if (profData.isEmpty)
      return DashboardResponseDataModel(IsRefrenceInAllowed: false);
    Map<String, dynamic> responseJson = jsonDecode(profData);
    return DashboardResponseDataModel.fromJson(responseJson);
  }

  void setUserProfile(DashboardResponseDataModel? profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (profile == null)
      profile = DashboardResponseDataModel(IsRefrenceInAllowed: false);
    var touchuser = prefs.getString(_keyTouchUserName);

    if (profile.UserName != touchuser) {
      prefs.remove(_keyTouchID);
      prefs.remove(_keyTouchUserName);
    }
    var strProfile = jsonEncode(profile); //.convert(profile);
    dp(msg: "user save", arg: strProfile);
    prefs.setString(_keyProfileData, strProfile);
  }

  Future<String> getDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDeviceId) ?? "";
  }

  void setDeviceId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyDeviceId, id);
  }

  Future<bool> isDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkTheme) ?? false;
  }

  Future<bool> setDarkTheme(bool isEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_keyDarkTheme, isEnabled);
  }

  Future<bool> getTouchID() async {
    var user = await getUserProfile();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var touchuser = prefs.getString(_keyTouchUserName);
    if (user.UserName != touchuser) return false;
    return prefs.getBool(_keyTouchID) ?? false;
  }

  Future<bool> setTouchID(bool isTurnOn) async {
    var user = await getUserProfile();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyTouchUserName, user.UserName);
    return prefs.setBool(_keyTouchID, isTurnOn);
  }

  Future<bool> isGlow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyGlowID) ?? true;
  }

  Future<bool> setGlow(bool isGlowOn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_keyGlowID, isGlowOn);
  }

  Future<bool> saveimage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_imageID, path);
  }

  Future<String> Loadimage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_imageID) ?? "";
    return imagePath;
  }

  String base64Strng(Uint8List data) {
    return base64Encode(data);
  }

  Image imagefrombase64String(String base64String) {
    return Image.memory(base64Decode(base64String), fit: BoxFit.fill);
  }
}
