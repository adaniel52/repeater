import 'package:flutter/material.dart';
import '../screens/photo_view_screen.dart';
import 'my_container.dart';

class NotesItemContainer extends StatelessWidget {
  final String title;
  final String image;
  const NotesItemContainer(
      {super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    PhotoViewScreen(title: title, image: image))));
      },
      child: MyContainer(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FittedBox(child: Text(title)),
          Divider(
              color:
                  Theme.of(context).textTheme.bodyLarge!.color ?? Colors.black),
          Hero(
            tag: '$image-tag',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/$image'),
            ),
          )
        ]),
      ),
    );
  }
}
