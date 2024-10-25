import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/rubu.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
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
  List<Rubu> rubus = [];
  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserPreferences>(context, listen: false).getUser();
    final originalRubus = user!.juzs[widget.number - 1].rubus;
    rubus = originalRubus.map((e) => e.copyWith()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Juz ${widget.number} Details'),
          ],
        ),
      ),
      body: ListView(
        padding: Styles.screenPadding,
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
              contentPadding: Styles.noPadding,
              title: Text('Rubu $rubuNumber'),
              value: e.isMemorized,
              onChanged: (value) {
                setState(() {
                  e.isMemorized = value;
                });
              },
            );
          }),
          LargeGap(),
          FilledButton(
            child: Text('Confirm Changes'),
            onPressed: () async {
              await Provider.of<UserPreferences>(context, listen: false)
                  .updateRubus(
                widget.number,
                rubus,
              );
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MainNavigation()),
                (_) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
