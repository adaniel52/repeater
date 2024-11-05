import 'package:flutter/material.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/screens/home/juz_details_screen.dart';
import 'package:repeater/screens/home/maqras_progress_indicator.dart';
import 'package:repeater/utils/constants/styles.dart';

class JuzListTile extends StatelessWidget {
  const JuzListTile({
    super.key,
    required this.juz,
    required this.juzNumber,
  });

  final Juz juz;
  final int juzNumber;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('$juzNumber'),
      ),
      title: Text('Juz $juzNumber'),
      subtitle: ClipRRect(
        borderRadius: Styles.smallBorderRadius,
        child: MaqrasProgressIndicator(maqras: juz.maqras),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => JuzDetailsScreen(number: juzNumber),
          ),
        );
      },
    );
  }
}
