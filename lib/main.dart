import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/services/theme_provider.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/app_styles.dart';
import 'package:repeater/widgets/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Repeater',
      theme: AppStyles.lightTheme,
      darkTheme: AppStyles.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const Init(),
    );
  }
}
