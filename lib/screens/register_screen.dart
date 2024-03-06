import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/show_custom_dialog.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() toggle;
  const RegisterScreen({super.key, required this.toggle});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //show loading
  bool isLoading = false;

  //controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //dispose controllers
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  //register method
  Future<void> register() async {
    //loading
    setState(() {
      isLoading = true;
    });

    //if pass dont match
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        isLoading = false;
      });

      if (context.mounted) showCustomDialog(context, 'Password don\'t match.');
    }

    //if pass match
    else {
      //try login
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        setState(() {
          isLoading = false;
        });
      } on FirebaseAuthException catch (error) {
        setState(() {
          isLoading = false;
        });
        if (context.mounted) showCustomDialog(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  //greet
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const Text('Register to continue'),

                  const SizedBox(height: 24),

                  //textfiels
                  CustomTextField(
                    labelText: 'E-mail',
                    emailController: emailController,
                  ),

                  const SizedBox(height: 12),

                  CustomTextField(
                    labelText: 'Password',
                    emailController: passwordController,
                  ),

                  const SizedBox(height: 12),

                  CustomTextField(
                    labelText: 'Confirm password',
                    emailController: confirmPasswordController,
                  ),

                  const SizedBox(height: 24),

                  //register button
                  CustomButton(
                    onPressed: isLoading ? () {} : register,
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          )
                        : const Text('Register'),
                  ),

                  //register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: widget.toggle,
                        child: const Text('Log in'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
