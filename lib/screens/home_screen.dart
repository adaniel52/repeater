import 'package:flutter/material.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/spacing.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: Styles.padding1,
          child: (_user == null)
              ? Text('Loading')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tasks',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacing1(),
                    const Card(
                      margin: Styles.padding0,
                      child: ListTile(
                        title: Text('Sabqi'),
                        subtitle: Text('Page 0'),
                      ),
                    ),
                    const Spacing2(),
                    const Card(
                      margin: Styles.padding0,
                      child: ListTile(
                        title: Text('Sabqi'),
                        subtitle: Text('Page 0'),
                      ),
                    ),
                    const Spacing2(),
                    const Card(
                      margin: Styles.padding0,
                      child: ListTile(
                        title: Text('Sabqi'),
                        subtitle: Text('Page 0'),
                      ),
                    ),
                    if (_user!.juz != 0) ...[
                      Spacing1(),
                      Text(
                        'Memorization Progress',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Spacing1(),
                      Card(
                        margin: Styles.padding0,
                        child: ListTile(
                          leading: const Icon(Icons.book_outlined),
                          title: const Text('Current Juz'),
                          subtitle: Text(_user!.juz.toString()),
                        ),
                      ),
                      Spacing2(),
                      Card(
                        margin: Styles.padding0,
                        child: ListTile(
                          leading: const Icon(Icons.brightness_low_outlined),
                          title: const Text('Current Rubu'),
                          subtitle: Text(_user!.rubu.toString()),
                        ),
                      ),
                    ],
                    Spacing1(),
                    Text(
                      'Review Progress',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Spacing2(),
                    ..._user!.reviewProgress.keys.map((e) {
                      return Text('Juz $e');
                    }),
                  ],
                ),
        ),
      ),
    );
  }
}
