import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/screens/intro_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/gap.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? selectedTheme;

  @override
  void initState() {
    super.initState();
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);
    selectedTheme = userPrefs.getUser()!.themeMode;
  }

  void _resetData() async {
    await UserPreferences().resetUser();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const IntroScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Styles.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }

  Widget _setThemeTile(UserPreferences userPrefs) => ListTile(
        contentPadding: Styles.noPadding,
        leading: Icon(Icons.dark_mode),
        title: Text('Theme'),
        trailing: DropdownButton(
          borderRadius: Styles.mediumBorderRadius,
          value: selectedTheme,
          items: ['System', 'Light', 'Dark'].map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
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
