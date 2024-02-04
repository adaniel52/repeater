import 'package:flutter/material.dart';
import '../screens/form_screen.dart';
import '../config/data.dart';
import '../widgets/my_button.dart';
import '../widgets/my_pop_scope.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset('assets/icon.png', width: 200)),
                    ),
                    const SizedBox(height: 36),
                    const Text('Repeater',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 200,
                          child: Text(
                              'An app to assist hafiz in murajaah Quran.',
                              textAlign: TextAlign.center)),
                    ),
                    const SizedBox(height: 36),
                    MyButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const FormScreen(type: FormType.signUp))),
                          );
                        },
                        label: 'Get Started!')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
