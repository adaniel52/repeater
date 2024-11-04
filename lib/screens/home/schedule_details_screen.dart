import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/main/main_navigation.dart';
import 'package:repeater/widgets/custom_list_view.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  final ScheduleEntry scheduleEntry;
  const ScheduleDetailsScreen({
    super.key,
    required this.scheduleEntry,
  });

  @override
  Widget build(BuildContext context) {
    final reviewType = scheduleEntry.reviewType!;
    final juzNumber = 'Juz ${scheduleEntry.juzNumber}';
    final fraction =
        (scheduleEntry.fraction == null) ? '' : ' · ${scheduleEntry.fraction}';
    final rubuNumbers = 'Rubu ${scheduleEntry.rubuNumbers.join(', ')}$fraction';
    final date = DateFormat.yMMMd().format(scheduleEntry.startDate);
    final time = DateFormat.jm().format(scheduleEntry.startDate);

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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MainNavigation()),
                      (_) => false,
                    );
                  },
                  child: const Text('Mark as Completed'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Delete'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
