import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/maqra.dart';
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
  List<Maqra> maqras = [];

  @override
  void initState() {
    super.initState();
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    final originalMaqras = user.juzs[widget.number - 1].maqras;
    maqras = originalMaqras.map((maqra) => maqra.copyWith()).toList();
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
          ListTile(
            title: Text(
              'Memorized Maqras',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: const Text('Which maqras did you still remember?'),
          ),
          const MediumGap(),
          ...maqras.map((maqra) {
            final maqraNumber = maqras.indexOf(maqra) + 1;
            return SwitchListTile(
              title: Text('Maqra $maqraNumber'),
              value: maqra.isMemorized,
              onChanged: (value) => setState(() => maqra.isMemorized = value),
            );
          }),
          const LargeGap(),
          ListTile(
            title: FilledButton(
              child: const Text('Confirm Changes'),
              onPressed: () async {
                await Provider.of<UserPreferences>(context, listen: false)
                    .updateMaqras(
                  widget.number,
                  maqras,
                );
                if (!context.mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainNavigation()),
                  (_) => false,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
