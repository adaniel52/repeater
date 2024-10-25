import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    _checkUser();
  }

  void _checkUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user =
          Provider.of<UserPreferences>(context, listen: false).getUser();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) =>
              (user == null) ? const IntroScreen() : const MainNavigation(),
        ),
        (_) => false,
      );
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
