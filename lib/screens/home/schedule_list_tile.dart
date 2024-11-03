import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/home/schedule_details_screen.dart';

class ScheduleListTile extends StatelessWidget {
  const ScheduleListTile({
    super.key,
    required this.scheduleEntry,
  });

  final ScheduleEntry scheduleEntry;

  @override
  Widget build(BuildContext context) {
    final juzNumber = scheduleEntry.juzNumber;
    final rubuNumbers = scheduleEntry.rubuNumbers.join(', ');
    final reviewType = scheduleEntry.reviewType;
    final fraction =
        (scheduleEntry.fraction == null) ? '' : ' (${scheduleEntry.fraction})';
    final text = '$reviewType | Juz $juzNumber · Rubu $rubuNumbers$fraction';
    final date =
        '${DateFormat.yMMMd().format(scheduleEntry.startDate)} · ${DateFormat.jm().format(scheduleEntry.startDate)}';

    return ListTile(
      title: Text(text),
      subtitle: Text(date),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScheduleDetailsScreen(
              scheduleEntry: scheduleEntry,
            ),
          ),
        );
      },
    );
  }
}
