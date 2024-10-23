import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/intro_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/widgets/main_navigation.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  void initState() {
    super.initState();
    _checkIfRegistered();
  }

  void _checkIfRegistered() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final User? user =
          Provider.of<UserPreferences>(context, listen: false).getUser();
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainNavigation(),
          ),
          (_) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => IntroScreen(),
          ),
          (_) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
