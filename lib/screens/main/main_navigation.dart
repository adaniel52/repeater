import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repeater/screens/home/home_screen.dart';
import 'package:repeater/screens/notes/notes_screen.dart';
import 'package:repeater/screens/settings/settings_screen.dart';
import 'package:repeater/utils/bool_alert_dialog.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldExit = await showBoolAlertDialog(
          context,
          title: 'Exit App?',
          content: 'Are you sure you want to close the app?',
          falseText: const Text('Cancel'),
          trueText: const Text('Exit', style: TextStyle(color: Colors.red)),
        );

        if (shouldExit && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
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
                groupAlignment: 0,
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
      ),
    );
  }
}
