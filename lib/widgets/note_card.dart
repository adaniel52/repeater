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
      // style: ElevatedButton.styleFrom(
      //   shape: const RoundedRectangleBorder(
      //       borderRadius: Styles.mediumBorderRadius),
      //   padding: Styles.noPadding,
      // ),
      onTap: () {
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
        padding: Styles.mediumPadding,
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
                  SmallGap(),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              );
            }
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
    );
  }
}
