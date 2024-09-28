import 'package:flutter/material.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants.dart';
import 'package:repeater/widgets/custom_button.dart';
import 'package:repeater/widgets/main_navigation.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _pageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _pageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _pageController.dispose();
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
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(borderRadius: defaultBorderRadius),
                ),
              ),
              const SizedBox(height: 10),
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
                onPressed: () async {
                  await UserPreferences.setUser(
                    User(
                      name: _nameController.text,
                      page: int.tryParse(_pageController.text) ?? 0,
                    ),
                  );
                  if (!context.mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const MainNavigation()),
                    (_) => false,
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
