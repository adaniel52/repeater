import 'package:flutter/material.dart';
import 'package:repeater/utils/constants.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    int crossAxisCount = (width / 270).floor();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: titleStyle,
        ),
      ),
      body: Padding(
        padding: defaultPadding,
        child: GridView.count(
          padding: const EdgeInsets.symmetric(vertical: 14),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: crossAxisCount,
          childAspectRatio: 15 / 9,
          children: const [
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
            NoteCard(),
          ],
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: defaultBorderRadius,
              child: Image(
                image: NetworkImage(
                  'https://github.com/adaniel52/repeater/blob/app/assets/nun-sakinah.png?raw=true',
                ),
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Nun Sakinah',
            //       style: titleStyle,
            //     ),
            //     Text(
            //       'Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. ',
            //       style: subtitleStyle,
            //       textAlign: TextAlign.justify,
            //       maxLines: 2,
            //       overflow: TextOverflow.ellipsis,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
