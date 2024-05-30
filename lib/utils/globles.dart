import 'package:flutter/material.dart';

GlobalKey<NavigatorState>? knavigatorKey = GlobalKey<NavigatorState>();

toNext(Widget widget) {
  Navigator.push(
      knavigatorKey!.currentState!.context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}
