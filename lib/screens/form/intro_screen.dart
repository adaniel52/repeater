import 'package:flutter/material.dart';
import 'package:repeater/screens/form/form_screen.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/centered_scrollable_column.dart';
import 'package:repeater/widgets/gap.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenteredScrollableColumn(
        children: [
          const ClipRRect(
            borderRadius: Styles.largeBorderRadius,
            child: Image(
              image: AssetImage('assets/icon/icon.png'),
              width: 200,
            ),
          ),
          const LargeGap(),
          Text(
            'Repeater',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            'An app to assist hafiz in scheduling timetables.',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const LargeGap(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FormScreen(),
                  ),
                );
              },
              child: const Text('Get Started!'),
            ),
          ),
        ],
      ),
    );
  }
}
