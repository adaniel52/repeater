import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/scaffold_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //logout
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const ScaffoldWrapper(
        centered: false,
        child: Column(
          children: [
            //header
            Text('Welcome, user!'),
          ],
        ),
      ),
    );
  }
}
