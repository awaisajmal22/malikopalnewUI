import 'dart:async';
import 'package:flutter/material.dart';
import 'package:malikopal/model/AppLandingResponse_model.dart';

class GlobalService {
  static final GlobalService _instance = GlobalService._internal();

  late AppLandingDataModel _appLandingData;
  late String _deviceId, _authToken, _fcmToken;
  late Map<String, String> _stringResourceMap;
  late StreamController _scCart, _scWishList;
  late GlobalKey<NavigatorState> navigatorKey;

  // passes the instantiation to the _instance object
  factory GlobalService() => _instance;

  GlobalService._internal() {
    _deviceId = '';
    _authToken = '';
    _fcmToken = '';
    _stringResourceMap = {};
    _scCart = StreamController<int>.broadcast();
    _scWishList = StreamController<int>.broadcast();
    navigatorKey = GlobalKey<NavigatorState>();
  }

  dispose() {
    _scCart.close();
    _scWishList.close();
  }

  String getString(String key) => _stringResourceMap[key] ?? key;

  String getStringWithNumber(String key, num value) =>
      getString(key).replaceFirst("{0}", value.toString());

  String getStringWithNumberStr(String key, String value) =>
      getString(key).replaceFirst("{0}", value);

  AppLandingDataModel getAppLandingData() => _appLandingData;

  void setAppLandingData(AppLandingDataModel value) {
    _appLandingData = value;
  }

  void setDeviceId(String id) => _deviceId = id;

  String getDeviceId() => _deviceId;

  void setAuthToken(String token) => _authToken = token;

  String getAuthToken() => _authToken;

  bool isLoggedIn() => _authToken.isNotEmpty;

  void setFcmToken(String token) => _fcmToken = token;

  String getFcmToken() => _fcmToken;
}
