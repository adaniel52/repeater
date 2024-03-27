import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/config/data.dart';
import '/screens/main_screen.dart';
import '/screens/intro_screen.dart';
import '/config/awesome_notifications.dart';
import 'config/shared_preferences.dart';
import 'config/theme_provider.dart';

void main() async {
  // Ensure that all necessary components are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  await initPreferences();

  // Initialize Awesome Notifications
  await initializeAwesomeNotifications();

  // Check if the app is allowed to send notifications, and request permission if not
  await requestNotificationPermission();

  runApp(
    // Use MultiProvider to manage multiple providers
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
  void initState() {
    // Set up notification listeners
    setupNotificationListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repeater',
      // Use the theme provided by the ThemeProvider
      theme: context.watch<ThemeProvider>().themeData,
      debugShowCheckedModeBanner: false,
      // Show the IntroScreen if the user is new, otherwise show the MainScreen
      home: UserData.isNew ? const IntroScreen() : const MainScreen(),
    );
  }
}

// Function to initialize Awesome Notifications
Future<void> initializeAwesomeNotifications() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'reminders_channel_key',
        channelName: 'Reminders',
        channelDescription: 'Reminds users in murajaah Quran',
        defaultColor: const Color.fromARGB(255, 37, 155, 120),
      ),
    ],
  );
}

// Function to check and request notification permission
Future<void> requestNotificationPermission() async {
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}

// Function to set up notification listeners
void setupNotificationListeners() {
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceviedMethod,
    onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceievedMethod,
  );
}
