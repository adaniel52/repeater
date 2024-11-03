import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repeater/models/schedule_entry.dart';

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
    final rubuNumbers = 'Rubu ${scheduleEntry.rubuNumbers.join(', ')}';
    final date = DateFormat.yMMMd().format(scheduleEntry.startDate);
    final time = DateFormat.jm().format(scheduleEntry.startDate);

    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar.medium(
              title: Text('Schedule Details'),
            ),
            SliverListTile(
              child: ListTile(
                leading: const Icon(Icons.loop),
                title: const Text('Review Type'),
                trailing: Text(reviewType),
              ),
            ),
            SliverListTile(
              child: ListTile(
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
            ),
            SliverListTile(
              child: ListTile(
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
            ),
            SliverListTile(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Mark as Completed'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverListTile extends StatelessWidget {
  const SliverListTile({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return child;
        },
        childCount: 1,
      ),
    );
  }
}
