import 'package:flutter/material.dart';
import 'package:repeater/screens/form/form_screen.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/gap.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width - Styles.smallBreakpoint) / 2;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Styles.screenSpacing,
              horizontal: (horizontalPadding < Styles.screenSpacing)
                  ? Styles.screenSpacing
                  : horizontalPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ClipRRect(
                  borderRadius: Styles.largeBorderRadius,
                  child: Image(
                    image: AssetImage('assets/icon/icon.png'),
                    height: 200,
                  ),
                ),
                const LargeGap(),
                Text(
                  'Repeater',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'An app to assist hafiz in scheduling timetables.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
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
          ),
        ),
      ),
    );
  }
}
