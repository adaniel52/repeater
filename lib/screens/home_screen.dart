import 'package:flutter/material.dart';
import '../utils/data.dart';
import '../widgets/scaffold_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldWrapper(
        centered: false,
        child: Column(
          children: [
            //header
            Row(
              children: [
                //greet
                const Text(
                  'Welcome, user!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                const Spacer(),

                //stats
                StatsContainer(
                  name: 'Juz',
                  value: Data.juz.toString(),
                ),

                const SizedBox(width: 8),

                StatsContainer(
                  name: 'Maqra',
                  value: Data.maqra.toString(),
                ),
              ],
            ),

            const SizedBox(height: 16),

            //tables
            TodoContainer(
              name: 'REVIEW CURRENT JUZ',
              value: 'JUZ ${Data.juz}',
              time: '8:00 AM',
            ),

            const SizedBox(height: 16),

            TodoContainer(
              name: 'MEMORISE NEXT MAQRA',
              value: 'MAQRA ${Data.maqra + 1}',
              time: '8:30 AM',
            ),

            const SizedBox(height: 16),

            TodoContainer(
              name: 'REVIEW PAST JUZ',
              value: 'JUZ 1 - ${Data.juz}',
              time: '9:00 AM',
            ),
          ],
        ),
      ),
    );
  }
}

class TodoContainer extends StatelessWidget {
  final String name;
  final String value;
  final String time;
  const TodoContainer({
    super.key,
    required this.name,
    required this.value,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(name.toUpperCase()),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

          const Divider(
            color: Colors.grey,
          ),

          //when
          Row(
            children: [
              const Icon(Icons.access_time),
              const SizedBox(width: 8),
              Text(time),
            ],
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
