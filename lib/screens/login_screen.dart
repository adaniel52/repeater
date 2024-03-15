import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/scaffold_wrapper.dart';

class LoginScreen extends StatefulWidget {
  final void Function() toggle;
  const LoginScreen({super.key, required this.toggle});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //show loading
  bool isLoading = false;

  //controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //dispose controllers
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  //login method
  Future<void> login() async {
    //loading
    setState(() {
      isLoading = true;
    });

    //try login
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
      if (!mounted) return;
      showSnackBar(context, error.toString());
    }
  }

  //forgot pass method
  void forgotPassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldWrapper(
        child: Column(
          children: [
            //greet
            const Text(
              'Welcome back!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const Text('Log in to continue'),

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

            //forgot pass button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: forgotPassword,
                child: const Text('Forgot password?'),
              ),
            ),

            const SizedBox(height: 12),

            //login button
            CustomButton(
              onPressed: isLoading ? null : login,
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : const Text('Log in'),
            ),

            //register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: widget.toggle,
                  child: const Text('Register'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
