import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/data.dart';
import '../config/shared_preferences.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_switch_list_tile.dart';
import '../widgets/my_text_form_field.dart';
import 'main_screen.dart';

class FormScreen extends StatefulWidget {
  final FormType type;
  const FormScreen({super.key, required this.type});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pageController = TextEditingController();
  bool khatam = false;
  bool fasting = false;

  @override
  void initState() {
    super.initState();
    khatam = UserData.hasKhatam;
    fasting = UserData.isFasting;
    if (UserData.page != 0) {
      pageController.text = UserData.page.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    switch (widget.type) {
      case FormType.signUp:
        title = 'Sign Up';
        break;
      case FormType.edit:
        title = 'Edit';
        break;
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 36),
                        if (widget.type == FormType.edit)
                          CustomSwitchListTile(
                            title: 'Fasting',
                            value: fasting,
                            onChanged: (value) {
                              setState(() {
                                fasting = value;
                              });
                            },
                          ),
                        const SizedBox(height: 12),
                        CustomSwitchListTile(
                          title: 'Khatam',
                          value: khatam,
                          onChanged: (value) {
                            setState(() {
                              khatam = value;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormField(
                          pageController: pageController,
                          label: 'Page',
                          hintText: '1 - 604',
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            int? temp = int.tryParse(value!);
                            if (temp == null || temp < 1 || temp > 604) {
                              return 'Invalid. Choose a number between 1 to 604.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 36),
                        CustomButton(
                          label: 'Confirm',
                          onTap: () {
                            _submitForm();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(16),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.adaptive.arrow_back,
                color: Theme.of(context).textTheme.bodyLarge!.color ??
                    Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      UserData.isNew = false;
      UserData.hasKhatam = khatam;
      UserData.isFasting = fasting;
      UserData.page = int.parse(pageController.text);
      UserData.juz = AppData.calcJuz(UserData.page);
      AppData.shouldRescheduleNotifications = true;

      await prefs.setBool('new', false);
      await prefs.setBool('khatam', khatam);
      await prefs.setBool('fasting', fasting);
      await prefs.setInt('page', UserData.page);
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    }
  }
}
