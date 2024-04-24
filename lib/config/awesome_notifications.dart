// import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController {
  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // log('set, ${receivedNotification.id}');
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // log('displayed, ${receivedNotification.id}');
  }

  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceievedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma('vm:entry-point')
  static Future<void> onActionReceviedMethod(
      ReceivedNotification receivedNotification) async {}
}
