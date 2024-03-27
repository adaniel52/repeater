import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/shared_preferences.dart';
import '../config/theme_provider.dart';
import '../screens/intro_screen.dart';
import '../config/data.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_switch_list_tile.dart';

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
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomContainer(
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) => CustomSwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: 'Dark Theme',
                  titleSize: 14,
                  value: AppData.useDarkTheme,
                  onChanged: (value) async {
                    setState(() {
                      AppData.useDarkTheme = value;
                    });
                    await prefs.setBool('darkTheme', value);
                    if (themeProvider.themeData.brightness !=
                        (value ? Brightness.dark : Brightness.light)) {
                      themeProvider.setTheme(value ? darkTheme : lightTheme);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    title: const Text(
                      'Confirmation',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text('Are you sure to reset all data?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          AppData.resetData();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const IntroScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const CustomContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Reset Data'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                AppData.showCustomDialog(
                    context: context,
                    title: 'About',
                    // content: Column(
                    //   children: [
                    //     ClipRRect(
                    //         borderRadius: BorderRadius.circular(12),
                    //         child: Image.asset('assets/icon.png')),
                    //     const Text('Repeater')
                    //   ],
                    // ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/icon.png',
                                width: 100,
                              )),
                          const SizedBox(height: 16),
                          const Text(
                            'Repeater',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // const SizedBox(height: 8),
                          const Text('Version: 0.1.1'),
                          const SizedBox(height: 16),
                          const Text(
                            'Description:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                              'An app to assist hafiz in murajaah Quran.'),
                          const SizedBox(height: 16),
                          const Text(
                            'Powered by:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const FlutterLogo(
                            style: FlutterLogoStyle.horizontal,
                            size: 100,
                          )
                        ],
                      ),
                    ),
                    actions: [
                      // TextButton(
                      //     onPressed: () {
                      //       launchUrl(
                      //           Uri.parse(
                      //               'https://adaniel52.github.io/repeater/'),
                      //           mode: LaunchMode.platformDefault);
                      //     },
                      //     child: const Text('Website')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close')),
                    ]);
              },
              child: const CustomContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('About'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
