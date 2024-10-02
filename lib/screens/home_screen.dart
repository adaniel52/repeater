import 'package:flutter/material.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/intro_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants.dart';
import 'package:repeater/utils/temp.dart';

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
        actions: [
          IconButton(
            onPressed: () async {
              await UserPreferences.setUser(User(page: 0));
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
      body: Padding(
        padding: defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Salam User',
              style: titleStyle,
            ),
            const SizedBox(height: 10),
            (_user == null)
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    children: [
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            leading: const Icon(Icons.brightness_low_outlined),
                            title: const Text('Juz'),
                            subtitle: Text(getJuz(_user!.page).toString()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            leading: const Icon(Icons.menu_book_outlined),
                            title: const Text('Page'),
                            subtitle: Text(_user!.page.toString()),
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            const Text(
              'Tasks',
              style: titleStyle,
            ),
            const SizedBox(height: 10),
            const Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                title: Text('Sabqi'),
                subtitle: Text('Page 0'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
