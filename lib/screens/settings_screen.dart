import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/screens/intro_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/choice_chips.dart';
import 'package:repeater/widgets/gap.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String selectedTheme;

  @override
  void initState() {
    super.initState();
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);
    selectedTheme = userPrefs.getUser()!.themeMode;
  }

  void _resetData() async {
    await UserPreferences().resetUser();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const IntroScreen(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Scrollbar(
        child: ListView(
          padding: Styles.screenPadding,
          children: [
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            MediumGap(),
            _setThemeTile(userPrefs),
            LargeGap(),
            Text(
              'Danger Zone',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            MediumGap(),
            _resetDataTile(),
          ],
        ),
      ),
    );
  }

  Widget _setThemeTile(UserPreferences userPrefs) => ListTile(
        contentPadding: Styles.noPadding,
        leading: Icon(Icons.dark_mode),
        title: Text('Theme'),
        trailing: ChoiceChips(
          options: ['System', 'Light', 'Dark'],
          selected: selectedTheme,
          onSelected: (value) {
            setState(() {
              selectedTheme = value;
            });
            userPrefs.updateUser(themeMode: value);
          },
        ),
      );

  Widget _resetDataTile() => ListTile(
        contentPadding: Styles.noPadding,
        leading: Icon(Icons.delete),
        title: Text('Reset Data'),
        onTap: _resetData,
      );
}
