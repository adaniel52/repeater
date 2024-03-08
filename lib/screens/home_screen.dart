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
      body: ScaffoldWrapper(
        centered: false,
        child: Column(
          children: [
            //header
            const Row(
              children: [
                //greet
                Text(
                  'Welcome, user!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                Spacer(),

                //stats
                StatsContainer(
                  name: 'Juz',
                  value: '27',
                ),

                SizedBox(width: 8),

                StatsContainer(
                  name: 'Page',
                  value: '555',
                ),
              ],
            ),

            const SizedBox(height: 12),

            //tables
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 77, 77, 77),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //what
                  Text('Review previous 2 pages'.toUpperCase()),
                  const Text(
                    '553 - 554',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 8),

                  //when
                  const Row(children: [
                    Icon(Icons.timer),
                    SizedBox(width: 8),
                    Text('8:00 AM'),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatsContainer extends StatelessWidget {
  final String name;
  final String value;
  const StatsContainer({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(name),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
