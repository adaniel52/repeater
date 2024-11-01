import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/home/juz_details_screen.dart';
import 'package:repeater/screens/home/rubus_progress_indicator.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_list_view.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Juz> filteredJuzs = [];
  Map<String, bool> filters = {
    'Fully Memorized': false,
    'Partially Memorized': false,
    'Not Memorized': false,
  };
  List<ScheduleEntry> todaySchedules = [];
  List<ScheduleEntry> upcomingSchedules = [];

  @override
  void initState() {
    super.initState();
    _getSchedules();
  }

  void _getSchedules() {
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    filteredJuzs = user.juzs;
    final now = DateTime.now();

    final tempTodaySchedules = <ScheduleEntry>[];
    final tempUpcomingSchedules = <ScheduleEntry>[];
    for (final scheduleEntry in user.schedules) {
      if (scheduleEntry.startDate.day == now.day) {
        tempTodaySchedules.add(scheduleEntry);
      } else if (scheduleEntry.startDate.isAfter(now)) {
        tempUpcomingSchedules.add(scheduleEntry);
      }
    }
    setState(() {
      todaySchedules = tempTodaySchedules;
      upcomingSchedules = tempUpcomingSchedules;
    });
  }

  void _filterJuzs(List<Juz> allJuzs) {
    setState(() {
      filteredJuzs = allJuzs.where((juz) {
        if (filters['Fully Memorized']! && !juz.isFullyMemorized) return false;
        if (filters['Partially Memorized']! && !juz.isPartiallyMemorized) {
          return false;
        }
        if (filters['Not Memorized']! && !juz.isNotMemorized) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: CustomListView(
        children: [
          ..._tasksSection(user),
          if (user.juz != null) ...[
            const LargeGap(),
            ..._memorizationSection(user),
          ],
          const LargeGap(),
          ..._overallProgressSection(user),
        ],
      ),
    );
  }

  List<Widget> _tasksSection(User user) => [
        const SectionTitle('Tasks'),
        if (todaySchedules.isEmpty)
          const ListTile(title: Text('You got no task.'))
        else
          ...todaySchedules.map((scheduleEntry) {
            final juzNumber = scheduleEntry.juzNumber;
            // final juz = user.juzs[juzNumber - 1];
            return ListTile(
              title: Text('Manzil - Juz $juzNumber'),
              subtitle: Text('${scheduleEntry.startDate.toLocal()}'),
              trailing: const Icon(Icons.chevron_right),
            );
          }),
        const SectionTitle('Upcoming Tasks'),
        if (upcomingSchedules.isEmpty)
          const ListTile(
            title: Text('You got no upcoming tasks.'),
          )
        else
          ...upcomingSchedules.map((scheduleEntry) {
            final juzNumber = scheduleEntry.juzNumber;
            // final juz = user.juzs[juzNumber - 1];
            return ListTile(
              title: const Text('Manzil - Review Memorized Juz'),
              subtitle: Text('Juz $juzNumber'),
              trailing: const Icon(Icons.chevron_right),
            );
          }),
      ];

  List<Widget> _memorizationSection(User user) => [
        const SectionTitle('Memorization'),
        ListTile(
          leading: const Icon(Icons.book_outlined),
          title: const Text('Current Juz'),
          trailing: Text(user.juz.toString()),
        ),
        ListTile(
          leading: const Icon(Icons.brightness_low_outlined),
          title: const Text('Current Rubu'),
          trailing: Text(user.rubu.toString()),
        ),
      ];

  List<Widget> _overallProgressSection(User user) => [
        const SectionTitle('Overall Progress'),
        ListTile(
          title: Wrap(
            spacing: Styles.smallSpacing,
            children: filters.keys.map((key) {
              return ChoiceChip(
                label: Text(key),
                selected: filters[key]!,
                onSelected: (value) {
                  filters.forEach((key, _) {
                    filters[key] = false;
                  });

                  setState(() => filters[key] = value);
                  _filterJuzs(user.juzs);
                },
              );
            }).toList(),
          ),
        ),
        if (filteredJuzs.isEmpty)
          const ListTile(
            title: Text('No results.'),
          )
        else
          ...filteredJuzs.map((juz) {
            final juzNumber = user.juzs.indexOf(juz) + 1;
            return ListTile(
              leading: CircleAvatar(
                child: Text('$juzNumber'),
              ),
              title: Text('Juz $juzNumber'),
              subtitle: ClipRRect(
                borderRadius: Styles.smallBorderRadius,
                child: RubusProgressIndicator(rubus: juz.rubus),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => JuzDetailsScreen(number: juzNumber),
                  ),
                );
              },
            );
          }),
      ];
}
