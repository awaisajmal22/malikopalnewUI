import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malikopal/services/GlobalService.dart';
import 'package:malikopal/utils/Const.dart';

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;
  static bool _isVisible = false;

  void showLoader() {
    if (_isVisible) {
      return;
    } else {
      _isVisible = true;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Platform.isIOS
                ? CupertinoAlertDialog(content: LoadingIndicator(true))
                : AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    // backgroundColor: Colors.grey[800],
                    content: LoadingIndicator(true),
                  ));
      },
    ).then((value) {
      debugPrint('imp1 - progress dialog closed');
      _isVisible = false;
    });
  }

  void showIndicator() {
    if (_isVisible) {
      return;
    } else {
      _isVisible = true;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Platform.isIOS
                ? CupertinoAlertDialog(content: LoadingIndicator(false))
                : AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    // backgroundColor: Colors.grey[800],
                    content: LoadingIndicator(false),
                  ));
      },
    ).then((value) {
      debugPrint('imp1 - progress dialog closed');
      _isVisible = false;
    });
  }

  void hideLoader() {
    if (_isVisible) Navigator.of(context).pop();
  }

  bool isVisible() => _isVisible;
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator(this.ShowText);
  final bool ShowText;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        // color: Colors.grey[800],
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              ShowText ? _getHeading(context) : Container(),
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(strokeWidth: 3),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return Padding(
        child: Text(
          GlobalService().getString(Constant.COMMON_PLEASE_WAIT),
          style: TextStyle(
              // color: Colors.white,
              fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }
}
