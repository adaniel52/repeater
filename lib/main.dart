import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/test.dart';
import 'package:repeater/utils/theme_mode.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserPreferences()),
        // ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);
    final themeMode = mapStringtoThemeMode(userPrefs.getUser()!.themeMode);
    return MaterialApp(
      title: 'Repeater',
      theme: Styles.lightTheme,
      darkTheme: Styles.darkTheme,
      themeMode: themeMode,
      home: const Test(),
    );
  }
}
