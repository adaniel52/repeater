import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/screens/intro_screen.dart';
import 'package:repeater/services/theme_provider.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    selectedTheme = _mapThemeModeToString(themeProvider.themeMode);
  }

  ThemeMode _mapStringtoThemeMode(String theme) {
    switch (theme) {
      case 'Light':
        return ThemeMode.light;
      case 'Dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _mapThemeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System';
    }
  }

  void _resetData() async {
    await UserPreferences.resetUser();
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: Styles.padding1,
        child: Column(
          children: [
            // SwitchListTile(
            //   secondary: Icon(Icons.dark_mode),
            //   title: Text('Dark Theme'),
            //   // subtitle: Text('Reset the app as if it was new'),
            //   value: Provider.of<ThemeProvider>(context).isDarkTheme,
            //   onChanged: (_) {
            //     Provider.of<ThemeProvider>(context, listen: false)
            //         .toggleDarkTheme();
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Theme'),
              trailing: DropdownButton(
                  value: selectedTheme,
                  items: ['Light', 'Dark', 'System'].map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value;
                    });
                    themeProvider.setThemeMode(_mapStringtoThemeMode(value!));
                  }),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Reset Data'),
              subtitle: Text('Reset the app as if it was new'),
              onTap: _resetData,
            ),
          ],
        ),
      ),
    );
  }
}
