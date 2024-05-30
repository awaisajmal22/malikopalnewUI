import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malikopal/main.dart';
import 'package:malikopal/model/AppLandingResponse_model.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScopeModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: ScreenUtilInit(
            designSize: Size(392, 834), builder: (context, child) => MyApp()));
  }
}

class AppModel extends Model {
  // Set All default values here
  AppLandingDataModel _appLandingData = AppLandingDataModel(
    // primaryThemeColor: '#10CB3C',
    // bottomBarActiveColor: '#10CB3C',
    // bottomBarInactiveColor: '#808080',
    // bottomBarBackgroundColor: '#f7f6f6',
    // topBarTextColor: '#ffffff',
    // topBarBackgroundColor: '#ffffff',
    // rtl: true,
    rtl: false,
  );
  bool _darkTheme = false;
  bool _currentTouchID = false;
  bool _glow = true;
  SessionData sessionData = SessionData();

  AppLandingDataModel get appLandingData => _appLandingData;
  bool get isDarkTheme => _darkTheme;
  bool get isTouchID => _currentTouchID;
  bool get isGlow => _glow;

  void updateAppLandingData() {
    // _appLandingData = newData;
    SessionData().isDarkTheme().then((isEnabled) {
      _darkTheme = isEnabled;
      notifyListeners();
    });
  }

  void setGlowMode(bool glow) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // const _keyGlowID = '_keyGlowSetting';

    SessionData().setGlow(glow).then((isEnabled) {
      isEnabled = glow;
      _glow = glow;
      notifyListeners();
      print("Glow Enabled From Modal $_glow");
      // prefs.setBool(_keyGlowID, _glow);
    });
  }

  void seThemeMode(bool isDark) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // const _keyDarkTheme = '_keyDarkTheme';

    SessionData().setDarkTheme(isDark).then((isEnabled) {
      isEnabled = isDark;
      _darkTheme = isDark;
      notifyListeners();
      print("Theme Enabled From Modal $_darkTheme");
      // prefs.setBool(_keyDarkTheme, _darkTheme);
    });
  }

  void setTouchID(bool isTouchID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const _keyTouchID = '_keyTouchID';

    debugPrint('TouchID Enabled -- $isTouchID');
    _currentTouchID = isTouchID;
    notifyListeners();

    prefs.setBool(_keyTouchID, _currentTouchID);
  }

  String deviceID() {
    String source = '';
    if (Platform.isAndroid) {
      source = "android";
    } else if (Platform.isIOS) {
      source = "iOS";
    }
    return source;
  }
}

// class isDarkThemeEnable extends StatefulWidget {
//   const isDarkThemeEnable({Key? key}) : super(key: key);

//   @override
//   State<isDarkThemeEnable> createState() => _isDarkThemeEnableState();
// }

// class _isDarkThemeEnableState extends State<isDarkThemeEnable> {
//   bool darkTheme = false;
//   @override
//   void initState() {
//     super.initState();
//     SessionData().isDarkTheme().then((value) {
//       setState(() {
//         darkTheme = value;
//         print("Themee State : $darkTheme");
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
