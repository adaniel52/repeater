import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/home/juz_details_screen.dart';
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

  @override
  void initState() {
    super.initState();
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    filteredJuzs = user.juzs;

    final schedules = <ScheduleEntry>[];
    for (final scheduleEntry in user.schedules) {
      if (scheduleEntry.startDate.day == DateTime.now().day) {
        schedules.add(scheduleEntry);
      }
    }
    setState(() {
      todaySchedules = schedules;
    });
  }

  void filterJuzs(List<Juz> allJuzs) {
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
    final width = MediaQuery.sizeOf(context).width;
    final getCrossAxisCount = (width / 175).floor();
    final crossAxisCount = (getCrossAxisCount < 1) ? 1 : getCrossAxisCount;
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
          ..._overallProgressSection(crossAxisCount, user),
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
              title: const Text('Manzil - Review Memorized Juz'),
              subtitle: Text('Juz $juzNumber'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            );
          }),
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: () {},
                child: const Text('Memorize New Juz'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Review Memorized Juz'),
              ),
            ],
          ),
        ),
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

  List<Widget> _overallProgressSection(int crossAxisCount, User user) => [
        const SectionTitle('Overall Progress'),
        ListTile(
          title: Wrap(
            spacing: Styles.smallSpacing,
            children: filters.keys.map((key) {
              return ChoiceChip(
                label: Text(key),
                selected: filters[key]!,
                onSelected: (value) {
                  filters.forEach((anotherKey, _) {
                    filters[anotherKey] = false;
                  });
                  setState(() {
                    filters[key] = value;
                  });
                  filterJuzs(user.juzs);
                },
              );
            }).toList(),
          ),
        ),
        const MediumGap(),
        (filteredJuzs.isEmpty)
            ? const ListTile(
                title: Text('No results.'),
              )
            : GridView.builder(
                padding: const EdgeInsets.only(
                  left: Styles.screenSpacing,
                  right: Styles.screenSpacing,
                  bottom: Styles.screenSpacing,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: Styles.smallSpacing,
                  crossAxisSpacing: Styles.smallSpacing,
                  childAspectRatio: 2,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredJuzs.length,
                itemBuilder: (context, index) {
                  final juz = filteredJuzs[index];
                  final juzNumber = user.juzs.indexOf(juz) + 1;
                  return ClipRRect(
                    // borderRadius: Styles.mediumBorderRadius,
                    child: Card.filled(
                      margin: Styles.noPadding,
                      child: ListTile(
                        contentPadding: Styles.noPadding,
                        leading: CircleAvatar(
                          child: Text('$juzNumber'),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    JuzDetailsScreen(number: juzNumber),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
      ];
}
