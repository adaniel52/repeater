import 'package:flutter/material.dart';
import 'package:repeater/utils/constants.dart';
import 'package:repeater/utils/temp.dart';
import 'package:repeater/widgets/note_card.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    int crossAxisCount = (width / 300).floor();
    double childWidth = width / crossAxisCount;
    double childHeight = childWidth * 9 / 16;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: titleStyle,
        ),
      ),
      body: Padding(
        padding: defaultPadding,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 14),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: childWidth / (childHeight + 70),
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final e = notes[index];
            return NoteCard(
              imageUrl: e['imageUrl']!,
              title: e['title']!,
              subtitle: e['subtitle']!,
            );
          },
        ),
      ),
    );
  }
}
