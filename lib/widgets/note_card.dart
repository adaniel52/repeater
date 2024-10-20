import 'package:flutter/material.dart';
import 'package:repeater/screens/notes/note_details_screen.dart';
import 'package:repeater/utils/constants/styles.dart';

class NoteCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String contentUrl;
  const NoteCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.contentUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: Styles.borderRadius1),
        padding: Styles.padding0,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoteDetailsScreen(
              imageUrl: imageUrl,
              title: title,
              contentUrl: contentUrl,
            ),
          ),
        );
      },
      child: Padding(
        padding: Styles.padding2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: imageUrl,
              child: ClipRRect(
                borderRadius: Styles.borderRadius2,
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
            ),
            const Expanded(child: SizedBox()),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Colors.lightGreen[100],
                //         borderRadius: Styles.borderRadius2,
                //       ),
                //       child: Text(
                //         'Tajweed',
                //       ),
                //     ),
                //     SizedBox(width: 4),
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Colors.orange[100],
                //         borderRadius: Styles.borderRadius2,
                //       ),
                //       child: Text(
                //         'Recommended',
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
