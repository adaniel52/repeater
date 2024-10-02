import 'package:flutter/material.dart';
import 'package:repeater/screens/notes/note_photo_view.dart';
import 'package:repeater/utils/constants.dart';

class NoteDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  const NoteDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: titleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: defaultPadding,
          child: Center(
            child: SizedBox(
              width: 600,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                NotePhotoView(imageUrl: imageUrl),
                          ),
                        );
                      },
                      child: Hero(
                        tag: imageUrl,
                        child: ClipRRect(
                          borderRadius: defaultBorderRadius,
                          child: Image(
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    Text(subtitle),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}