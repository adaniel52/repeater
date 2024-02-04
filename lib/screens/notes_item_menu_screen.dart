import 'package:flutter/material.dart';
import '../widgets/notes_item_container.dart';

class NotesItemMenuScreen extends StatelessWidget {
  final String title;
  final List list;
  const NotesItemMenuScreen(
      {super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notes',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, height: 1)),
          Text(title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, height: 1))
        ],
      )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.count(
                crossAxisCount: (width / 150).floor(),
                childAspectRatio: 1.2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: list
                    .map((e) =>
                        NotesItemContainer(title: e.title, image: e.image))
                    .toList())),
      ),
    );
  }
}
