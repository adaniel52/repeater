import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/maqra.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/main/main_navigation.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/widgets/custom_list_view.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  final ScheduleEntry scheduleEntry;
  final bool editable;
  const ScheduleDetailsScreen({
    super.key,
    required this.scheduleEntry,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);
    final user = userPrefs.getUser()!;

    final reviewType = scheduleEntry.reviewType!;
    final juzNumber = 'Juz ${scheduleEntry.juzNumber}';
    final fraction =
        (scheduleEntry.fraction == null) ? '' : ' · ${scheduleEntry.fraction}';
    final maqraNumbers =
        'Maqra ${scheduleEntry.maqraNumbers.join(', ')}$fraction';
    final date = DateFormat.yMMMd().format(scheduleEntry.startDate);
    final time = DateFormat.jm().format(scheduleEntry.startDate);

    void toggleCompletion() {
      final newScheduleEntry = scheduleEntry.copyWith(
        isCompleted: !scheduleEntry.isCompleted,
      );
      final schedules = List<ScheduleEntry>.from(user.schedules);
      final index = schedules.indexOf(scheduleEntry);
      schedules[index] = newScheduleEntry;

      final juzNumber = scheduleEntry.juzNumber;
      final maqraNumber = scheduleEntry.maqraNumbers.last;
      final hasKhatam = user.juzNumber == null;

      var newJuzNumber = juzNumber;
      var newMaqraNumber = maqraNumber;
      var newHasKhatam = hasKhatam;

      // check if sabaq
      if (scheduleEntry.fraction == '4/4') {
        if (!scheduleEntry.isCompleted) {
          // completing
          if (maqraNumber != 8) {
            // same juz
            newMaqraNumber = maqraNumber + 1;
          } else {
            // new juz
            if (juzNumber != 30) {
              newJuzNumber = juzNumber + 1;
              newMaqraNumber = 1;
            } else {
              newHasKhatam = true;
            }
          }

          userPrefs.updateMaqra(
            juzNumber,
            maqraNumber,
            Maqra(isMemorized: true),
          );
        } else {
          // incompleting
          if (maqraNumber != 1) {
            // same juz
            newMaqraNumber = maqraNumber;
          } else {
            // old juz
            if (juzNumber != 1) {
              newJuzNumber = juzNumber - 1;
              newMaqraNumber = 8;
            } else {
              newJuzNumber = 1;
              newMaqraNumber = 1;
            }
          }

          userPrefs.updateMaqra(
            juzNumber,
            maqraNumber,
            Maqra(isMemorized: false),
          );
        }
      }

      userPrefs.updateUser(
        schedules: schedules,
        juzNumber: newJuzNumber,
        maqraNumber: newMaqraNumber,
      );

      if (newHasKhatam) userPrefs.setKhatam();

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
                Text(maqraNumbers),
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
            title: FilledButton.icon(
              onPressed: (editable) ? toggleCompletion : null,
              icon: Icon(
                scheduleEntry.isCompleted ? Icons.close : Icons.check,
              ),
              label: Text(
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
