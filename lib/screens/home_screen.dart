import 'package:flutter/material.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/intro_screen.dart';
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
        title: const Text(
          'Salam User',
          style: Styles.title,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await UserPreferences.resetUser();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const IntroScreen(),
                ),
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: Styles.padding1,
            child: (_user == null)
                ? Text('Loading')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tasks',
                        style: Styles.title,
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
                          style: Styles.title,
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
                        style: Styles.title,
                      ),
                      Spacing2(),
                      ..._user!.reviewProgress.keys.map((e) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Color selectedColor;
                            switch (_user!.reviewProgress[e]) {
                              case 'Partially':
                                selectedColor = Colors.greenAccent;
                                break;
                              case 'Fully':
                                selectedColor = Colors.green;
                                break;
                              default:
                                selectedColor = Colors.grey;
                            }
                            return Container(
                              color: selectedColor,
                              child: Text('Juz $e'),
                            );
                          },
                        );
                      })
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
