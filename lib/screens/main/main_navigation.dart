import 'package:flutter/material.dart';
import 'package:repeater/screens/home/home_screen.dart';
import 'package:repeater/screens/notes/notes_screen.dart';
import 'package:repeater/screens/settings/settings_screen.dart';
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
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      bottomNavigationBar: (width < Styles.largeBreakpoint)
          ? NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (value) => setState(() => index = value),
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
              onDestinationSelected: (value) => setState(() => index = value),
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
