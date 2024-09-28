import 'package:flutter/material.dart';
import 'package:repeater/utils/constants.dart';
import 'package:repeater/widgets/custom_button.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final TextEditingController _pageController;

  @override
  void initState() {
    _pageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: defaultPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: titleStyle,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _pageController,
                decoration: const InputDecoration(
                  labelText: 'Page',
                  hintText: '1 - 604',
                  border: OutlineInputBorder(borderRadius: defaultBorderRadius),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                labelText: 'Submit',
                onPressed: () {
                  print(_pageController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
