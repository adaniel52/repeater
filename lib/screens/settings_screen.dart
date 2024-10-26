import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/screens/form/intro_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/choice_chips.dart';
import 'package:repeater/widgets/custom_list_view.dart';
import 'package:repeater/widgets/gap.dart';

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
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    currentTheme = user.themeMode;
    currentColor = Color(user.colorScheme);
  }

  void _resetData() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to reset the app data?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await UserPreferences().resetUser();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const IntroScreen(),
                ),
                (_) => false,
              );
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: CustomListView(
        children: [
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const MediumGap(),
          _setThemeTile(userPrefs),
          _setColorSchemeTile(userPrefs),
          const LargeGap(),
          Text(
            'Danger Zone',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const MediumGap(),
          _resetDataTile(),
        ],
      ),
    );
  }

  Widget _setThemeTile(UserPreferences userPrefs) => ListTile(
        contentPadding: Styles.noPadding,
        leading: const Icon(Icons.dark_mode),
        title: const Text('Theme'),
        trailing: ChoiceChips(
          options: const ['System', 'Light', 'Dark'],
          selected: currentTheme,
          onSelected: (value) async {
            setState(() {
              currentTheme = value;
            });
            await userPrefs.updateUser(themeMode: value);
          },
        ),
      );

  Widget _setColorSchemeTile(UserPreferences userPrefs) => PopupMenuButton(
        tooltip: '',
        child: ListTile(
          contentPadding: Styles.noPadding,
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
          setState(() {
            currentColor = value;
          });
          await userPrefs.updateUser(colorScheme: currentColor.value);
        },
      );

  Widget _resetDataTile() => ListTile(
        contentPadding: Styles.noPadding,
        leading: const Icon(Icons.delete),
        title: const Text('Reset Data'),
        onTap: _resetData,
      );
}
