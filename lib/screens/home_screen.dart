import 'package:flutter/material.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    User? user = await UserPreferences.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salam User'),
      ),
      body: (_user == null)
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
                    if (_user!.juz != 0) ...[
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
                                subtitle: Text(_user!.juz.toString()),
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
                                subtitle: Text(_user!.rubu.toString()),
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
                    ..._user!.reviewProgress.keys.map((e) {
                      return Text('Juz $e: ${_user!.reviewProgress[e]}');
                    }),
                  ],
                ),
              ),
            ),
    );
  }
}
