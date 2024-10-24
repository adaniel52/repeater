import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_button.dart';
import 'package:repeater/widgets/main_navigation.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);
    final user = userPrefs.getUser();
    final firstJuz = user!.memorization!.first;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Task',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Memorized New Juz',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: Styles.screenPadding,
        child: Column(
          children: [
            CustomButton(
              child: Text('Toggle Memorized'),
              onPressed: () {
                setState(() {
                  for (var e in firstJuz.rubus) {
                    e.isMemorized = !e.isMemorized;
                  }
                });
              },
            ),
            Text(firstJuz.isMemorized.toString()),
            CustomButton(
              child: Text('rebuild'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainNavigation()),
                  (_) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
