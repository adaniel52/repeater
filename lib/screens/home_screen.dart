import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
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
    int crossAxisCount = (width / 200).floor();
    final userPrefs = Provider.of<UserPreferences>(context);
    final user = userPrefs.getUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: (user == null)
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: Styles.screenPadding,
              children: [
                Text(
                  'Tasks',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const MediumGap(),
                const Card.filled(
                  child: ListTile(
                    title: Text('Sabqi'),
                    subtitle: Text('Page 0'),
                  ),
                ),
                if (user.juz != null) ...[
                  LargeGap(),
                  Text(
                    'Memorization Progress',
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
                ],
                LargeGap(),
                Text(
                  'Review Progress',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                MediumGap(),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: Styles.smallSpacing,
                      crossAxisSpacing: Styles.smallSpacing,
                      childAspectRatio: 2),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: user.memorization!.length,
                  itemBuilder: (context, index) {
                    final juz = user.memorization![index];
                    return Card.filled(
                      child: ListTile(
                        title: Text('Juz ${index + 1}'),
                        subtitle: Text(juz.fluency),
                      ),
                    );
                  },
                )
                // ...user.memorization!.keys.map((e) {
                //   return Padding(
                //     padding: EdgeInsets.only(
                //       top: e == '1' ? 0 : Styles.smallSpacing,
                //     ),
                //     child: Card.filled(
                //       child: ListTile(
                //         title: Text('Juz $e'),
                //         subtitle: Text(user.memorization![e]),
                //       ),
                //     ),
                //   );
                // }),
              ],
            ),
    );
  }
}
