import 'package:flutter/material.dart';
import 'package:repeater/screens/intro_screen.dart';
import 'package:repeater/services/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        // brightness: Brightness.dark,
      ),
      home: const IntroScreen(),
    );
  }
}
