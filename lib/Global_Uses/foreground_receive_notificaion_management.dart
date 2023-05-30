import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ForegroundNotificationManagement {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings("app_icon");

  ForegroundNotificationManagement() {
    final InitializationSettings _initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);

    log("Foreground Notification Constructor");

    initAll(_initializationSettings);
  }

  initAll(InitializationSettings initializationSettings) async {
    final response = await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings, onSelectNotification: (payload) async {
      log("On Select Notification Payload: $payload");
    });

    log("Local Notification Initialization Status: $response");
  }

  Future<void> showNotification(
      {required String title, required String body}) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
              "CHANNEL ID", "Generation Youtube Tutorial",
              channelDescription:
                  "This is made under Youtube Generation Tutorial",
              importance: Importance.max);

      const NotificationDetails generalNotificationDetails =
          NotificationDetails(android: androidDetails);

      await _flutterLocalNotificationsPlugin
          .show(0, title, body, generalNotificationDetails, payload: title);
    } catch (e) {
      log("Foreground Notification Error :${e.toString()}");
    }
  }
}
