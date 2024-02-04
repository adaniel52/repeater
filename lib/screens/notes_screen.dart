import 'package:flutter/material.dart';
import '../config/data.dart';
import '../widgets/notes_category_menu_item.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount =
        screenWidth ~/ 150; // Adjust item width based on screen width

    return Center(
      child: SizedBox(
        width: 300,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          itemCount: NotesData.notesMenuItems.length,
          itemBuilder: (context, index) {
            final NotesMenuItem element = NotesData.notesMenuItems[index];
            return NotesCategoryMenuItem(
              icon: element.icon,
              title: element.title,
              list: element.list,
            );
          },
        ),
      ),
    );
  }
}
