import 'package:flutter/material.dart';
import 'package:repeater/screens/form_screen.dart';
import 'package:repeater/utils/constants.dart';
import 'package:repeater/widgets/custom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: defaultPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ClipRRect(
                borderRadius: defaultBorderRadius,
                child: Image(
                  image: AssetImage('assets/icon.png'),
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Repeater',
                style: titleStyle,
              ),
              const Text(
                'An app to assist hafiz in scheduling timetables.',
                textAlign: TextAlign.center,
                style: subtitleStyle,
              ),
              const SizedBox(height: 20),
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
