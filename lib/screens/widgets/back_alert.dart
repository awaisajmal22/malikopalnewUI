import 'dart:io' show Platform, exit;

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Login_Screen.dart';

class OnBackToLogout {
  Future<bool> Logout(
      {required BuildContext ctx,
      required String title,
      required String content}) async {
    return await showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text(title,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyText2!.color)),
        content: Text(content, style: Theme.of(context).textTheme.bodyText1),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("No", style: Theme.of(context).textTheme.bodyText2),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, MyHomePage.routeName);
            },
            child: Text("Yes", style: Theme.of(context).textTheme.bodyText2),
          ),
        ],
      ),
    );
  }
}

class OnExit {
  // late DateTime currentBackPressTime = DateTime.now();

  Future<bool> ExitApp(
      {required BuildContext ctx,
      required String title,
      required String content}) async {
    return await showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text(title,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyText2!.color)),
        content: Text(content, style: Theme.of(context).textTheme.bodyText1),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("No", style: Theme.of(context).textTheme.bodyText2),
          ),
          TextButton(
            onPressed: () {
              // exit(0);
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            child: Text("Yes", style: Theme.of(context).textTheme.bodyText2),
          ),
        ],
      ),
    );
  }

  // Future<bool> onWillExit(BuildContext ctx) {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == "" ||
  //       now.difference(currentBackPressTime) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     showSnackBar(ctx, "Press again to exit app", true);
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }
}
