import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/rubu.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_list_view.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/screens/main/main_navigation.dart';

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
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    final originalRubus = user.juzs[widget.number - 1].rubus;
    rubus = originalRubus.map((rubu) => rubu.copyWith()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Juz ${widget.number}'),
          ],
        ),
      ),
      body: CustomListView(
        width: Styles.largeBreakpoint,
        children: [
          const Text('Which rubu did you still remembered?'),
          const MediumGap(),
          ...rubus.map((rubu) {
            final rubuNumber = rubus.indexOf(rubu) + 1;
            return SwitchListTile(
              contentPadding: Styles.noPadding,
              title: Text('Rubu $rubuNumber'),
              value: rubu.isMemorized,
              onChanged: (value) {
                setState(() {
                  rubu.isMemorized = value;
                });
              },
            );
          }),
          const LargeGap(),
          FilledButton(
            child: const Text('Confirm Changes'),
            onPressed: () async {
              await Provider.of<UserPreferences>(context, listen: false)
                  .updateRubus(
                widget.number,
                rubus,
              );
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const MainNavigation()),
                (_) => false,
              );
            },
          )
        ],
      ),
    );
  }
}