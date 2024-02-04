import 'package:flutter/material.dart';
import '../config/data.dart';
import '../screens/form_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_pop_scope.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset('assets/icon.png', width: 200),
                    ),
                  ),
                  const SizedBox(height: 36),
                  const Text(
                    'Repeater',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'An app to assist hafiz in murajaah Quran.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),
                  CustomButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FormScreen(type: FormType.signUp)),
                      );
                    },
                    label: 'Get Started!',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
