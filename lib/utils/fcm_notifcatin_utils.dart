import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../repositories/auth_repo/AuthRepository.dart';

FirebaseMessaging messagingInstance = FirebaseMessaging.instance;

class NotificationUtils {
  FlutterLocalNotificationsPlugin? fltNotification;

  static final NotificationUtils _instance = NotificationUtils._internal();

  factory NotificationUtils() => _instance;

  NotificationUtils._internal();

  void initMessaging() {
    //

    notitficationPermission();

    var androiInit = const AndroidInitializationSettings('ic_launcher');

    var iosInit = const IOSInitializationSettings();

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification?.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //

      dp(msg: "Notification received", arg: message.notification?.toMap());

      showNotification(message);
      //
    });
  }

  void showNotification(RemoteMessage message) async {
    //

    var androidDetails = AndroidNotificationDetails('1', 'channelName',
        channelDescription: 'channel Description',
        priority: Priority.high,
        importance: Importance.high,
        playSound: true);

    var iosDetails  = const IOSNotificationDetails(
      presentSound: true,
      presentBadge: true,
    );

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await fltNotification?.show(0, message.notification?.title,
        message.notification?.body, generalNotificationDetails,
        payload: 'Notification');
  }

  void notitficationPermission() async {
    await messagingInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  //
}
