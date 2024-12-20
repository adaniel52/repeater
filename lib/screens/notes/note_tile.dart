import 'package:flutter/material.dart';
import 'package:repeater/screens/notes/note_details_screen.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/gap.dart';

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
    return InkWell(
      borderRadius: Styles.mediumBorderRadius,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => NoteDetailsScreen(
              imageUrl: imageUrl,
              title: title,
              contentUrl: contentUrl,
            ),
          ),
        );
      },
      child: Image(
        image: NetworkImage(imageUrl),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: imageUrl,
                  child: ClipRRect(
                    borderRadius: Styles.mediumBorderRadius,
                    child: child,
                  ),
                ),
                const SmallGap(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
      ),
    );
  }
}
