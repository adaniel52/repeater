import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/rubu.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/main/main_navigation.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/widgets/custom_list_view.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  final ScheduleEntry scheduleEntry;
  const ScheduleDetailsScreen({
    super.key,
    required this.scheduleEntry,
  });

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);
    final user = userPrefs.getUser()!;

    final reviewType = scheduleEntry.reviewType!;
    final juzNumber = 'Juz ${scheduleEntry.juzNumber}';
    final fraction =
        (scheduleEntry.fraction == null) ? '' : ' · ${scheduleEntry.fraction}';
    final rubuNumbers = 'Rubu ${scheduleEntry.rubuNumbers.join(', ')}$fraction';
    final date = DateFormat.yMMMd().format(scheduleEntry.startDate);
    final time = DateFormat.jm().format(scheduleEntry.startDate);

    void markAsCompleted() {
      final newScheduleEntry = scheduleEntry.copyWith(
        isCompleted: !scheduleEntry.isCompleted,
      );
      final schedules = List<ScheduleEntry>.from(user.schedules);
      final index = schedules.indexOf(scheduleEntry);
      schedules[index] = newScheduleEntry;

      final lastRubuNumber = scheduleEntry.rubuNumbers.last;

      int? juzNumber;
      int? rubuNumber;

      if (user.juzNumber != null && scheduleEntry.fraction == '4/4') {
        //not khatam
        if (scheduleEntry.isCompleted) {
          //incompleting + set to current juz
          juzNumber = scheduleEntry.juzNumber;

          if (lastRubuNumber == 8) {
            rubuNumber = 8;
          } else {
            rubuNumber = lastRubuNumber;
          }

          userPrefs.updateRubu(
            scheduleEntry.juzNumber,
            lastRubuNumber,
            Rubu(isMemorized: false),
          );
        } else {
          //completing

          if (lastRubuNumber == 8) {
            //increment juz
            if (scheduleEntry.juzNumber == 30) {
              userPrefs.setKhatam();
            } else {
              juzNumber = scheduleEntry.juzNumber + 1;
              rubuNumber = 1;
            }
          } else {
            rubuNumber = lastRubuNumber + 1;
          }

          userPrefs.updateRubu(
            scheduleEntry.juzNumber,
            lastRubuNumber,
            Rubu(isMemorized: true),
          );
        }
      } else {
        //khatam
        if (scheduleEntry.isCompleted) {
          juzNumber = scheduleEntry.juzNumber;
          rubuNumber = lastRubuNumber;
          userPrefs.updateRubu(
            scheduleEntry.juzNumber,
            lastRubuNumber,
            Rubu(isMemorized: false),
          );
        } else {
          userPrefs.updateRubu(
            scheduleEntry.juzNumber,
            lastRubuNumber,
            Rubu(isMemorized: true),
          );
        }
      }

      userPrefs.updateUser(
        schedules: schedules,
        juzNumber: juzNumber,
        rubuNumber: rubuNumber,
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MainNavigation()),
        (_) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Details'),
      ),
      body: CustomListView(
        children: [
          ListTile(
            leading: const Icon(Icons.loop),
            title: const Text('Review Type'),
            trailing: Text(reviewType),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Portion'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(juzNumber),
                Text(rubuNumbers),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Time'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(date),
                Text(time),
              ],
            ),
          ),
          ListTile(
            title: FilledButton(
              onPressed: markAsCompleted,
              child: Text(
                scheduleEntry.isCompleted
                    ? 'Mark as Incompleted'
                    : 'Mark as Completed',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
