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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Salam User',
                  style: Styles.title,
                ),
                const Spacing1(),
                (_user == null)
                    ? const Text('Usernotfound!')
                    : Text(_user!.toJson()),
                // : Row(
                //     children: [
                //       Expanded(
                //         child: Card(
                //           margin: Styles.padding0,
                //           child: ListTile(
                //             leading:
                //                 const Icon(Icons.brightness_low_outlined),
                //             title: const Text('Juz'),
                //             subtitle: Text(_user!.juz.toString()),
                //           ),
                //         ),
                //       ),
                //       const Spacing2(),
                //       Expanded(
                //         child: Card(
                //           margin: Styles.padding0,
                //           child: ListTile(
                //             leading: const Icon(Icons.menu_book_outlined),
                //             title: const Text('Page'),
                //             subtitle: Text('0'),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                const Spacing1(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
