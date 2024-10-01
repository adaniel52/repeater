import 'package:flutter/material.dart';
import 'package:repeater/utils/constants.dart';
import 'package:repeater/utils/temp.dart';

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
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: childWidth / (childHeight + 75),
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

class NoteCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  const NoteCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: defaultBorderRadius,
              child: Image(
                image: NetworkImage(imageUrl),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            ),
            const Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: titleStyle,
                ),
                Text(
                  subtitle,
                  style: subtitleStyle,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
