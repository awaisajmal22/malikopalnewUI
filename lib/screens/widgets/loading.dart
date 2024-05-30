import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String? loadingMessage;
  Loading({Key? key, this.loadingMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              loadingMessage ?? "Loading...",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 24),
            Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
          ],
        ),
      ),
    );
  }
}
