import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/home/task_form_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_button.dart';
import 'package:repeater/widgets/gap.dart';

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
          : ListView(
              padding: Styles.screenPadding,
              children: [
                ..._tasksSection(),
                if (user.juz != null) ...[
                  LargeGap(),
                  ..._memorizationSection(user),
                ],
                LargeGap(),
                ..._overallProgressSection(crossAxisCount, user),
              ],
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
        Text('You got no task.'),
        MediumGap(),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TaskFormScreen()),
                  );
                },
                child: Text('Memorize New Juz'),
              ),
            ),
            SmallGap(),
            Expanded(
              child: CustomButton(
                child: Text('Review Memorized Juz'),
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
        MediumGap(),
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
            SmallGap(),
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
        MediumGap(),
        Text(
          'Sort by',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        MediumGap(),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: Styles.smallSpacing,
            crossAxisSpacing: Styles.smallSpacing,
            childAspectRatio: 1.4,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: user.memorization!.length,
          itemBuilder: (context, index) {
            final juz = user.memorization![index];
            return Card.filled(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Juz ${index + 1}'),
                    // subtitle: Text('Last reviewed: none'),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: Styles.mediumPadding,
                    child: LinearProgressIndicator(
                      borderRadius: Styles.smallBorderRadius,
                      value: juz.rubus.where((e) => e.isMemorized).length / 8,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ];
}
