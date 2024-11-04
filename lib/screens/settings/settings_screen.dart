import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/screens/form/intro_screen.dart';
import 'package:repeater/screens/main/main_navigation.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/bool_alert_dialog.dart';
import 'package:repeater/widgets/custom_list_view.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/widgets/section_title.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String currentTheme;
  late Color currentColor;

  final List<Color> colorSchemeOptions = [
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.deepOrange,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    currentTheme = user.themeMode;
    currentColor = Color(user.colorScheme);
  }

  void _resetData() async {
    final result = await showBoolAlertDialog(
      context,
      title: 'Reset Data',
      content: 'All app data will be removed.',
      falseText: const Text('Cancel'),
      trueText: const Text(
        'Reset',
        style: TextStyle(color: Colors.red),
      ),
    );

    if (!result) return;

    await UserPreferences().resetUser();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const IntroScreen(),
      ),
      (_) => false,
    );
  }

  void _resetSchedules() async {
    final result = await showBoolAlertDialog(
      context,
      title: 'Reset Schedule',
      content:
          'The app will generate some new schedules to replace the current ones.',
      falseText: const Text('Cancel'),
      trueText: const Text(
        'Reset',
        style: TextStyle(color: Colors.red),
      ),
    );

    if (!result) return;

    await UserPreferences().logIn(shouldReschedule: true);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: CustomListView(
        children: [
          const SectionTitle('Appearance'),
          _setThemeTile(userPrefs),
          _setColorSchemeTile(userPrefs),
          const MediumGap(),
          const SectionTitle('More'),
          _rescheduleTile(),
          _resetDataTile(),
          _aboutAppTile(),
        ],
      ),
    );
  }

  Widget _setThemeTile(UserPreferences userPrefs) => PopupMenuButton(
        tooltip: '',
        child: ListTile(
          leading: const Icon(Icons.brightness_6),
          title: const Text('Theme'),
          trailing: Text(currentTheme),
        ),
        itemBuilder: (_) {
          return ['System', 'Light', 'Dark'].map((e) {
            return PopupMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList();
        },
        onSelected: (value) async {
          setState(() => currentTheme = value);
          await userPrefs.updateUser(themeMode: value);
        },
      );

  Widget _setColorSchemeTile(UserPreferences userPrefs) => PopupMenuButton(
        tooltip: '',
        child: ListTile(
          leading: const Icon(Icons.color_lens),
          title: const Text('Color Scheme'),
          trailing: CircleAvatar(backgroundColor: currentColor),
        ),
        itemBuilder: (_) {
          return colorSchemeOptions.map(
            (color) {
              return PopupMenuItem(
                value: color,
                child: CircleAvatar(backgroundColor: color),
              );
            },
          ).toList();
        },
        onSelected: (value) async {
          setState(() => currentColor = value);
          await userPrefs.updateUser(colorScheme: currentColor.value);
        },
      );

  Widget _rescheduleTile() => ListTile(
        leading: const Icon(Icons.calendar_month),
        title: const Text('Reset Schedules'),
        onTap: _resetSchedules,
      );

  Widget _resetDataTile() => ListTile(
        leading: const Icon(Icons.delete),
        title: const Text('Reset Data'),
        onTap: _resetData,
      );
  Widget _aboutAppTile() => const AboutListTile(
        icon: Icon(Icons.info),
        applicationIcon: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image(
            image: AssetImage('assets/icon/icon.png'),
            width: 50,
          ),
        ),
        applicationVersion: 'v0.1.0',
        aboutBoxChildren: [
          Text('An app to assist hafiz in scheduling timetables.'),
        ],
      );
}
