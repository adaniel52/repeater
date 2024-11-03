import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:repeater/main.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/home/schedule_details_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';

const remindersChannelName = 'Reminders';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  NotificationService._internal();
  factory NotificationService() => _instance;

  static const _notificationIdKey = 'notificationId';
  static late Box<int> _notificationIdBox;

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final user = UserPreferences().getUser()!;
    final startDate = DateTime.parse(receivedAction.payload!['startDate']!);
    print(startDate.toString());
    final scheduleEntry = user.schedules
        .firstWhere((scheduleEntry) => scheduleEntry.startDate == startDate);

    MainApp.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ScheduleDetailsScreen(
          scheduleEntry: scheduleEntry,
        ),
      ),
    );
  }

  Future<void> init() async {
    _notificationIdBox = await Hive.openBox('notificationIdBox');
    if (!_notificationIdBox.containsKey(_notificationIdKey)) {
      _notificationIdBox.put(_notificationIdKey, -1);
    }

    AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher_foreground',
      [
        NotificationChannel(
          channelKey: remindersChannelName,
          channelName: remindersChannelName,
          channelDescription: 'Notification channel for reminders',
          importance: NotificationImportance.Max,
          defaultColor: Styles.themeColor,
          channelShowBadge: true,
        ),
      ],
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

  int getNextNotificationId() {
    final newId = (_notificationIdBox.get(_notificationIdKey)! + 1) % 64;
    _notificationIdBox.put(_notificationIdKey, newId);
    return newId;
  }

  void scheduleNotification(ScheduleEntry scheduleEntry) {
    final juzNumber = scheduleEntry.juzNumber;
    final rubuNumbers = scheduleEntry.rubuNumbers.join(', ');
    final title = 'Manzil';
    final body = 'Juz $juzNumber - Rubu $rubuNumbers';
    final startDate = scheduleEntry.startDate;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: getNextNotificationId(),
        channelKey: remindersChannelName,
        category: NotificationCategory.Reminder,
        title: title,
        body: body,
        timeoutAfter: const Duration(hours: 1),
        payload: {
          'startDate': '$startDate',
        },
      ),
      schedule: NotificationCalendar(
        allowWhileIdle: true,
        day: startDate.day,
        hour: startDate.hour,
        minute: startDate.minute,
      ),
    );
  }

  Future<void> clearAll() async {
    AwesomeNotifications().cancelAll();
  }
}
