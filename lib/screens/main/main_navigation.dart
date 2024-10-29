import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/home/home_screen.dart';
import 'package:repeater/screens/notes/notes_screen.dart';
import 'package:repeater/screens/settings_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  static const _screens = [
    HomeScreen(),
    NotesScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _logIn();
  }

  void _logIn() async {
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);
    final user = userPrefs.getUser()!;

    if (user.lastLoginTime.day != DateTime.now().day) {
      final memorizedJuzs =
          user.juzs.where((juz) => juz.isFullyMemorized).toList();
      final schedules = <ScheduleEntry>[];
      for (var juz in memorizedJuzs) {
        final index = memorizedJuzs.indexOf(juz);
        schedules.add(
          ScheduleEntry(
            startDate: DateTime.now().add(Duration(days: index)),
            reviewType: 'Manzil',
            reviewList: {juz: null},
          ),
        );
      }
      await userPrefs.updateUser(schedules: schedules);
    }

    await userPrefs.updateUser(
      lastLoginTime: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      bottomNavigationBar: (width < Styles.largeBreakpoint)
          ? NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (value) {
                setState(() {
                  index = value;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.note_outlined),
                  selectedIcon: Icon(Icons.note),
                  label: 'Notes',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            )
          : null,
      body: Row(
        children: [
          if (width >= Styles.largeBreakpoint)
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: (value) {
                setState(() {
                  index = value;
                });
              },
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.note_outlined),
                  selectedIcon: Icon(Icons.note),
                  label: Text('Notes'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
            ),
          Expanded(child: _screens[index]),
        ],
      ),
    );
  }
}
