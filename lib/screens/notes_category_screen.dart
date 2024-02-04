import 'package:flutter/material.dart';
import '../widgets/notes_item_container.dart';

class NotesCategoryScreen extends StatelessWidget {
  final String categoryTitle;
  final List notesList;

  const NotesCategoryScreen({
    super.key,
    required this.categoryTitle,
    required this.notesList,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
            Text(
              categoryTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: (screenWidth / 150).floor(),
          childAspectRatio: 1.2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: notesList
              .map((note) => NotesItemContainer(
                    title: note.title,
                    image: note.image,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
