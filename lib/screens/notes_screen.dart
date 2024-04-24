import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../config/data.dart';
import '../widgets/notes_category_menu_item.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 140,
            child: NotesCategoryMenuItem(
              icon: NotesData.notesMenuItems[0].icon,
              title: NotesData.notesMenuItems[0].title,
              list: NotesData.notesMenuItems[0].list,
            ),
          ),
          SizedBox(
            width: 140,
            child: NotesCategoryMenuItem(
              icon: NotesData.notesMenuItems[1].icon,
              title: NotesData.notesMenuItems[1].title,
              list: NotesData.notesMenuItems[1].list,
            ),
          ),
        ],
      )),
    );

    /*
    return Center(
      child: SizedBox(
        width: 300,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
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
    */
  }
}
