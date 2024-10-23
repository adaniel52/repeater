import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/rubu.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/utils/theme_mode.dart';
import 'package:repeater/widgets/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(JuzAdapter());
  Hive.registerAdapter(RubuAdapter());
  await UserPreferences().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserPreferences()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserPreferences>(context).getUser();
    return MaterialApp(
      title: 'Repeater',
      theme: Styles.lightTheme,
      darkTheme: Styles.darkTheme,
      themeMode: user == null
          ? ThemeMode.system
          : mapStringtoThemeMode(user.themeMode),
      home: const Init(),
    );
  }
}
