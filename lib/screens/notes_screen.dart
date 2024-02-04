import 'package:flutter/material.dart';
import '../config/data.dart';
import '../widgets/notes_menu_item_container.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: NotesData.notesMenuItems.length,
              itemBuilder: (context, index) {
                NotesMenuItem element = NotesData.notesMenuItems[index];
                return NotesMenuItemContainer(
                    icon: element.icon,
                    title: element.title,
                    list: element.list);
              }),
        ),
      ),
    );
  }
}
