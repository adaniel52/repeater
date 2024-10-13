import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/spacing.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _pageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _pageController = TextEditingController();
    _nameController.text = 'Guest';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: Styles.padding1,
        child: Center(
          child: SizedBox(
            width: 400,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: Styles.title,
                  ),
                  const Spacing1(),
                  TextFormField(
                    controller: _pageController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.menu_book_outlined),
                      labelText: 'Page',
                      hintText: '1 - 604',
                      border: OutlineInputBorder(
                        borderRadius: Styles.borderRadius1,
                      ),
                    ),
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                    validator: (value) {
                      int? page = int.tryParse(value!);
                      if (page == null || page < 1 || page > 604) {
                        return 'Invalid! Please choose a number between 1 and 604.';
                      }
                      return null;
                    },
                  ),
                  const Spacing1(),
                  // CustomButton(
                  //   labelText: 'Submit',
                  //   onPressed: () async {
                  //     if (_formKey.currentState!.validate()) {
                  //       await UserPreferences.setUser(
                  //         User(
                  //           page: int.tryParse(_pageController.text) ?? 0,
                  //         ),
                  //       );
                  //       if (!context.mounted) return;
                  //       Navigator.of(context).pushAndRemoveUntil(
                  //         MaterialPageRoute(
                  //             builder: (context) => const MainNavigation()),
                  //         (_) => false,
                  //       );
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
