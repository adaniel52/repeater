import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../config/shared_preferences.dart';
import '../config/data.dart';
import '../widgets/custom_container.dart';
import '../widgets/stats_container.dart';
import '../widgets/timetable_entry_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void handleIsFasting(bool value) {
      setState(() {
        UserData.isFasting = value;
        AppData.shouldRescheduleNotifications = true;
        AppData.lastIsFastingPrompt = AppData.now.day;
      });
      AppData.updateTimetable();
      prefs.setBool('fasting', value);
    }

    if (AppData.shouldRescheduleNotifications) {
      AwesomeNotifications().cancelAllSchedules();
      AppData.updateTimetable();
      log('reset');
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Salam,',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('User',
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Column(
                  children: [
                    StatsContainer(
                        prop: 'Khatam',
                        value: UserData.hasKhatam ? 'Yes' : 'No'),
                    const SizedBox(height: 4),
                    StatsContainer(prop: 'Page', value: UserData.page),
                    const SizedBox(height: 4),
                    StatsContainer(prop: 'Juz', value: UserData.juz),
                  ],
                )
              ]),
          const SizedBox(height: 24),
          if (AppData.lastIsFastingPrompt != AppData.now.day)
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              CustomContainer(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Are you fasting today?'),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            handleIsFasting(false);
                          },
                          child: const Icon(Icons.clear)),
                      const SizedBox(width: 4),
                      InkWell(
                          onTap: () {
                            handleIsFasting(true);
                          },
                          child: const Icon(Icons.check))
                    ],
                  )
                ],
              )),
              const SizedBox(height: 24)
            ]),
          if (AppData.timetable != [])
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: AppData.timetable.map((e) {
                  for (int day in e.weekdays) {
                    if (day == AppData.now.weekday) {
                      String title = '';
                      String subtitle = '';
                      dynamic reference = '';
                      switch (e.type) {
                        case MurajaahType.prasabaq:
                          title = 'Pra-Sabaq';
                          subtitle = 'Memorise next page';
                          reference =
                              'Page ${AppData.calcRelativePage(UserData.page + 1)}';
                          break;
                        case MurajaahType.sabaq:
                          title = 'Sabaq';
                          subtitle = 'Recite next page to a teacher';
                          reference =
                              'Page ${AppData.calcRelativePage(UserData.page + 1)}';
                          break;
                        case MurajaahType.sabqi:
                          title = 'Sabqi';
                          subtitle = 'Review current juz';
                          reference = 'Juz ${UserData.juz}';
                          break;
                        case MurajaahType.usbuiyyah:
                          title = 'Usbuiyyah';
                          subtitle = 'Review current week memorisation';
                          break;
                        case MurajaahType.qadimah:
                          title = 'Qadimah';
                          subtitle = 'Review past memorisation';
                          break;
                        case MurajaahType.mukhtar:
                          title = 'Mokhtar';
                          subtitle = 'Review current month memorisation';
                          break;
                      }
                      if (AppData.shouldRescheduleNotifications) {
                        if (AppData.timetable.indexOf(e) ==
                            (AppData.timetable.length - 1)) {
                          AppData.shouldRescheduleNotifications = false;
                        }
                        AwesomeNotifications().createNotification(
                            content: NotificationContent(
                                id: AppData.timetable.indexOf(e),
                                channelKey: 'reminders_channel_key',
                                title: title,
                                body:
                                    '${e.time.format(context)} ${(reference != '') ? (' | $reference') : ''}'),
                            schedule: NotificationCalendar(
                                allowWhileIdle: true,
                                second: 0,
                                hour: e.time.hour,
                                minute: e.time.minute,
                                repeats: true));
                      }
                      return TimetableEntryContainer(
                          title: title,
                          subtitle: subtitle,
                          time: e.time,
                          reference: reference);
                    }
                  }
                  return Container();
                }).toList()),
        ]),
      ),
    ));
  }
}
