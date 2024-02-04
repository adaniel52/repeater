import 'package:flutter/material.dart';
import '../screens/notes_item_menu_screen.dart';
import 'my_container.dart';

class NotesMenuItemContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final List list;
  const NotesMenuItemContainer(
      {super.key, required this.icon, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    NotesItemMenuScreen(title: title, list: list))));
      },
      child: MyContainer(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(24),
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 8),
              FittedBox(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
