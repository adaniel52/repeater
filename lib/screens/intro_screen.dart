import 'package:flutter/material.dart';
import 'package:repeater/screens/form_screen.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_button.dart';
import 'package:repeater/widgets/spacing.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Styles.padding1,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ClipRRect(
                borderRadius: Styles.borderRadius1,
                child: Image(
                  image: AssetImage('assets/icon.png'),
                  height: 200,
                ),
              ),
              const Spacing1(),
              const Text(
                'Repeater',
                style: Styles.title,
              ),
              const Text(
                'An app to assist hafiz in scheduling timetables.',
                textAlign: TextAlign.center,
                style: Styles.subtitle,
              ),
              const Spacing1(),
              CustomButton(
                labelText: 'Go',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FormScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
