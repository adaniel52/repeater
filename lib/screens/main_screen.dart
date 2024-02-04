import 'package:flutter/material.dart';
import '../config/data.dart';
import '../screens/form_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/home_screen.dart';
import '../screens/notes_screen.dart';
import '../widgets/custom_pop_scope.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final screens = [const HomeScreen(), const NotesScreen()];

  @override
  Widget build(BuildContext context) {
    return MyPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Repeater',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FormScreen(type: FormType.edit)));
                },
                icon: Icon(Icons.edit,
                    color: Theme.of(context).textTheme.bodyLarge!.color ??
                        Colors.black)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                },
                icon: Icon(Icons.settings,
                    color: Theme.of(context).textTheme.bodyLarge!.color ??
                        Colors.black))
          ],
        ),
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
              labelTextStyle: MaterialStatePropertyAll(
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
          child: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (index) {
                setState(() {
                  this.index = index;
                });
              },
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                    selectedIcon: Icon(Icons.home)),
                NavigationDestination(
                    icon: Icon(Icons.notes_outlined), label: 'Notes')
              ]),
        ),
      ),
    );
  }
}
