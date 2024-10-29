import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/home/juz_details_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_list_view.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/widgets/rubus_progress_indicator.dart';

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

  @override
  void initState() {
    super.initState();
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    filteredJuzs = user.juzs;
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
        Text(
          'Tasks',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const MediumGap(),
        ...user.schedules!.map((scheduleEntry) {
          final index = user.schedules!.indexOf(scheduleEntry);
          final juz = scheduleEntry.reviewList!.keys.first;
          final juzNumber = user.juzs.indexOf(juz) + 1;
          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0 : Styles.smallSpacing),
            child: Card.filled(
              child: ListTile(
                title: const Text('Manzil - Review Memorized Juz'),
                subtitle: Text('Juz $juzNumber'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.check),
                    ),
                    const SmallGap(),
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        // const Text('You got no task.'),
        const MediumGap(),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () {},
                child: const Text('Memorize New Juz'),
              ),
            ),
            const SmallGap(),
            Expanded(
              child: FilledButton.tonal(
                onPressed: () {},
                child: const Text('Review Memorized Juz'),
              ),
            ),
          ],
        ),
      ];

  List<Widget> _memorizationSection(User user) => [
        Text(
          'Memorization',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const MediumGap(),
        Row(
          children: [
            Expanded(
              child: Card.filled(
                child: ListTile(
                  leading: const Icon(Icons.book_outlined),
                  title: const Text('Current Juz'),
                  subtitle: Text(user.juz.toString()),
                ),
              ),
            ),
            const SmallGap(),
            Expanded(
              child: Card.filled(
                child: ListTile(
                  leading: const Icon(Icons.brightness_low_outlined),
                  title: const Text('Current Rubu'),
                  subtitle: Text(user.rubu.toString()),
                ),
              ),
            ),
          ],
        ),
      ];

  List<Widget> _overallProgressSection(int crossAxisCount, User user) => [
        Text(
          'Overall Progress',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const MediumGap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Filters',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const MediumGap(),
            Flexible(
              child: Wrap(
                spacing: Styles.smallSpacing,
                runSpacing: Styles.smallSpacing,
                alignment: WrapAlignment.end,
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
          ],
        ),
        const MediumGap(),
        (filteredJuzs.isEmpty)
            ? const Text(
                'No results.',
                textAlign: TextAlign.center,
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: Styles.smallSpacing,
                  crossAxisSpacing: Styles.smallSpacing,
                  childAspectRatio: 1.4,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredJuzs.length,
                itemBuilder: (context, index) {
                  final juz = filteredJuzs[index];
                  final juzNumber = user.juzs.indexOf(juz) + 1;
                  return ClipRRect(
                    borderRadius: Styles.mediumBorderRadius,
                    child: Card.filled(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: Styles.mediumPadding,
                                child: CircleAvatar(
                                  child: Text('$juzNumber'),
                                ),
                              ),
                              IconButton(
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
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          RubusProgressIndicator(rubus: juz.rubus),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ];
}
