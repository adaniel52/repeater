import 'package:flutter/material.dart';
import 'package:repeater/utils/constants.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: titleStyle,
        ),
      ),
      body: const Center(
        child: Text('body'),
      ),
    );
  }
}
