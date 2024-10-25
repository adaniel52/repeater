import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/home/juz_details_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/widgets/rubus_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    int crossAxisCount = (width / 175).floor();
    final userPrefs = Provider.of<UserPreferences>(context);
    final user = userPrefs.getUser();

    // List<int> schedule =
    //     ScheduleService(DateTime.now().subtract(Duration(days: 1)))
    //         .getTodaySchedule();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: (user == null)
          ? const Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: ListView(
                padding: Styles.screenPadding,
                children: [
                  ..._tasksSection(),
                  if (user.juz != null) ...[
                    const LargeGap(),
                    ..._memorizationSection(user),
                  ],
                  const LargeGap(),
                  ..._overallProgressSection(crossAxisCount, user),
                ],
              ),
            ),
    );
  }

  List<Widget> _tasksSection() => [
        Text(
          'Tasks',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const MediumGap(),
        // Card.filled(
        //   child: ListTile(
        //     title: Text('Sabaq'),
        //     subtitle: Text(
        //       'Maqra ${schedule.toString()}',
        //     ),
        //     trailing: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         IconButton.filledTonal(
        //           onPressed: () {},
        //           icon: const Icon(Icons.check),
        //         ),
        //         IconButton.filledTonal(
        //           onPressed: () {},
        //           icon: const Icon(Icons.close),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        const Text('You got no task.'),
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
        Text(
          'Sort by',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const MediumGap(),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: Styles.smallSpacing,
            crossAxisSpacing: Styles.smallSpacing,
            childAspectRatio: 1.4,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: user.juzs.length,
          itemBuilder: (context, index) {
            final juz = user.juzs[index];
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
                            child: Text('${index + 1}'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    JuzDetailsScreen(number: index + 1),
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
