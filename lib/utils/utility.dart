import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Login_Screen.dart';

// import 'package:url_launcher/url_launcher.dart';
// import 'package:html/parser.dart';
import 'package:malikopal/services/GlobalService.dart';
import 'package:malikopal/utils/shared_pref.dart';

Future<void> prepareSessionData() async {
  GlobalService _globalService = GlobalService();

  _globalService.setAuthToken(await SessionData().getAuthToken());

  final deviceID = await SessionData().getDeviceId();
  if (deviceID.isEmpty) {
    var newDeviceId = generateRandomDeviceId();
    SessionData().setDeviceId(newDeviceId);
    _globalService.setDeviceId(newDeviceId);
  } else {
    _globalService.setDeviceId(deviceID);
  }
}

String generateRandomDeviceId() {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  return List.generate(15, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String getFormattedDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
  try {
    return date != "" ? DateFormat(format).format(date) : '';
  } catch (e) {
    return '';
  }
}

bool isDarkThemeEnabled(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

showSnackBar(BuildContext context, String message, bool isError) {
  var mContext = GlobalService().navigatorKey.currentContext;
  if (mContext == null) mContext = context;

  ScaffoldMessenger.of(mContext).hideCurrentSnackBar();

  ScaffoldMessenger.of(mContext).showSnackBar(SnackBar(
    backgroundColor: isError ? Colors.red[600] : Colors.grey[800],
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
      maxLines: 5,
    ),
    duration: isError ? Duration(seconds: 3) : Duration(milliseconds: 1500),
    action: isError
        ? SnackBarAction(
            label: '✖',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(mContext!).hideCurrentSnackBar();
            },
          )
        : null,
  ));
}

CheckUnauthMessage(BuildContext context, String message) {
  print(message);
  var move = message.contains('Authorization has been denied');
  print(move);
  print('from new function');
  if (move) // == 'Authorization has been denied for this request.')
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (Context) => MyHomePage(),
      ),
    );
  }
}

// hexSting format #FFFFFF
Color parseColor(String hexString) {
  try {
    return Color(int.parse(hexString.replaceFirst('#', '0x')) + 0xFF000000);
  } catch (e) {
    return Colors.orange;
  }
}

// hexSting format #FFFFFF
int parseColorInt(String hexString) {
  try {
    return int.parse(hexString.replaceFirst('#', '0x')) + 0xFF000000;
  } catch (e) {
    return 0xFF121212;
  }
}

void removeFocusFromInputField(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

Widget sectionTitleWithDivider(String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Divider(color: Colors.grey[800])
      ],
    ),
  );
}
