import 'package:flutter/material.dart';
import 'package:repeater/utils/constants.dart';
import 'package:repeater/widgets/custom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: defaultPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: defaultBorderRadius,
                child: Image(
                  image: AssetImage('assets/icon.png'),
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Repeater',
                style: titleStyle,
              ),
              Text(
                'An app to assist hafiz in scheduling timetables.',
                textAlign: TextAlign.center,
                style: subtitleStyle,
              ),
              SizedBox(height: 20),
              CustomButton(labelText: 'Go'),
            ],
          ),
        ),
      ),
    );
  }
}
