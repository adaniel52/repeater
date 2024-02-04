import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/shared_preferences.dart';
import '../config/theme_provider.dart';
import '../screens/intro_screen.dart';
import '../config/data.dart';
import '../widgets/my_container.dart';
import '../widgets/my_switch_list_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Settings',
                style: TextStyle(fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /*
                    MyContainer(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Theme'),
                        DropdownButton(
                            icon: Icon(Icons.arrow_drop_down,
                                color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color ??
                                    Colors.black),
                            underline: Container(
                                height: 1,
                                color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color ??
                                    Colors.black),
                            value: context.watch<ThemeProvider>().themeData,
                            items: [
                              DropdownMenuItem(
                                  value: lightTheme,
                                  child: const Text('Light')),
                              DropdownMenuItem(
                                  value: darkTheme, child: const Text('Dark')),
                            ],
                            onChanged: (value) {
                              context.read<ThemeProvider>().setTheme(value!);
                              
                            })
                      ],
                    )),
                    */
                    MyContainer(
                        child: MySwitchListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: 'Dark Theme',
                      titleSize: 14,
                      value: AppData.useDarkTheme,
                      onChanged: (value) async {
                        setState(() {
                          AppData.useDarkTheme = value;
                        });
                        await prefs.setBool('darkTheme', value);
                        if (!context.mounted) return;
                        context
                            .read<ThemeProvider>()
                            .setTheme(value ? darkTheme : lightTheme);
                      },
                    )),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: ((context) => AlertDialog(
                                  title: const Text('Confirmation',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  content: const Text(
                                      'Are you sure to reset all data?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          AppData.resetData();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const IntroScreen()),
                                                  (route) => false);
                                        },
                                        child: const Text(
                                          'Reset',
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                )));
                      },
                      child: const MyContainer(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reset Data'),
                          Icon(Icons.chevron_right)
                        ],
                      )),
                    ),
                  ])),
        ));
  }
}
