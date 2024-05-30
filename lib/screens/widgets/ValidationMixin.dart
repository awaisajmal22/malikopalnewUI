import 'package:flutter/material.dart';
import 'package:malikopal/services/GlobalService.dart';

mixin ValidationMixin {
  bool isValidEmailAddress(String email) {
    if (email.isEmpty) {
      return false;
    }

    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  InputDecoration inputDecor(String labelTextKey, bool isRequired) {
    return InputDecoration(
      // contentPadding: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
      labelText: GlobalService().getString(labelTextKey),
      suffixIcon: isRequired
          ? Icon(
              Icons.star,
              size: 12, /*color: Colors.black,*/
            )
          : null,
    );
  }
}
