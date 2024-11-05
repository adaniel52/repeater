import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/screens/form/intro_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/screens/main/main_navigation.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userPrefs = Provider.of<UserPreferences>(context, listen: false);
      final user = userPrefs.getUser();
      if (user == null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const IntroScreen(),
          ),
          (_) => false,
        );
      } else {
        await userPrefs.logIn();
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const MainNavigation(),
          ),
          (_) => false,
        );

        if (!kIsWeb) return;

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Web Detected'),
            content: const Text(
              'Due to some limitations, you will not receive push notifications for reminders.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
