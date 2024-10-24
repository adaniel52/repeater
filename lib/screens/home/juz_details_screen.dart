import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/rubu.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_button.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/widgets/main_navigation.dart';

class JuzDetailsScreen extends StatefulWidget {
  final int number;
  const JuzDetailsScreen({
    super.key,
    required this.number,
  });

  @override
  State<JuzDetailsScreen> createState() => _JuzDetailsScreenState();
}

class _JuzDetailsScreenState extends State<JuzDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserPreferences>(context).getUser();
    final rubus = user!.juzs[widget.number - 1].rubus;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Juz Details'),
          ],
        ),
      ),
      body: Padding(
        padding: Styles.screenPadding,
        child: Column(
          children: [
            // CustomButton(
            //   child: Text('Toggle Memorized'),
            //   onPressed: () {
            //     setState(() {
            //       for (var e in firstJuz.rubus) {
            //         e.isMemorized = !e.isMemorized;
            //       }
            //     });
            //   },
            // ),
            // Text(firstJuz.isMemorized.toString()),
            ...rubus.map((e) {
              final rubuNumber = rubus.indexOf(e) + 1;
              return SwitchListTile(
                title: Text('Rubu $rubuNumber'),
                value: e.isMemorized,
                onChanged: (value) async {
                  await Provider.of<UserPreferences>(context, listen: false)
                      .updateRubu(
                          widget.number, rubuNumber, Rubu(isMemorized: value));
                  // e.isMemorized = value;
                },
              );
            }),
            LargeGap(),
            CustomButton(
              child: Text('Confirm Changes'),
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
