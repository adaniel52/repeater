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
    final userPrefs = Provider.of<UserPreferences>(context);
    final user = userPrefs.getUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Salam User'),
      ),
      body: (user == null)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: Styles.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SmallGap(),
                    const Card.filled(
                      child: ListTile(
                        title: Text('Sabqi'),
                        subtitle: Text('Page 0'),
                      ),
                    ),
                    if (user.juz != 0) ...[
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
                                leading:
                                    const Icon(Icons.brightness_low_outlined),
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
                    ...user.reviewProgress.keys.map((e) {
                      return Text('Juz $e: ${user.reviewProgress[e]}');
                    }),
                  ],
                ),
              ),
            ),
    );
  }
}
