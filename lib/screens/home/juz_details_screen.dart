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
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    final originalRubus = user.juzs[widget.number - 1].rubus;
    rubus = originalRubus.map((rubu) => rubu.copyWith()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width - 400) / 2;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Juz ${widget.number} Details'),
          ],
        ),
      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: Styles.screenSpacing,
            horizontal: (horizontalPadding < Styles.screenSpacing)
                ? Styles.screenSpacing
                : horizontalPadding,
          ),
          children: [
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
      ),
    );
  }
}
