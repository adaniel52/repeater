import 'package:flutter/material.dart';

import '../widgets/scaffold_wrapper.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScaffoldWrapper(
        child: Text('note'),
      ),
    );
  }
}
