import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:repeater/main.dart';
import 'package:repeater/screens/home/juz_details_screen.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  NotificationService._internal();
  factory NotificationService() => _instance;

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    MainApp.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const JuzDetailsScreen(number: 1),
      ),
    );
  }

  void init() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'reminders',
            channelName: 'Reminders',
            channelDescription: 'Notification channel for reminders')
      ],
      debug: true,
    );
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // void deleteAllNotifications(){
  //   AwesomeNotifications()
  // }
}
