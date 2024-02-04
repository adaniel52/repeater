import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/config/data.dart';
import '/screens/main_screen.dart';
import '/screens/intro_screen.dart';
import '/config/shared_preferences.dart';
import '/config/awesome_notifications.dart';
import 'config/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initPreferences();

  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'reminders_channel_key',
        channelName: 'Reminders',
        channelDescription: 'Reminds users in murajaah Quran',
        defaultColor: const Color.fromARGB(255, 37, 155, 120))
  ]);
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => ThemeProvider()))
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceviedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceievedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Brightness currentBrightness = MediaQuery.of(context).platformBrightness;
    return MaterialApp(
      title: 'Repeater',
      theme: context.watch<ThemeProvider>().themeData,
      debugShowCheckedModeBanner: false,
      home: UserData.isNew ? const IntroScreen() : const MainScreen(),
    );
  }
}

//TODO: icon,noti