import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class NotePhotoView extends StatelessWidget {
  final String imageUrl;
  const NotePhotoView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
          shadows: [
            Shadow(offset: Offset(1, 0)),
            Shadow(offset: Offset(0, 1)),
            Shadow(offset: Offset(-1, 0)),
            Shadow(offset: Offset(0, -1)),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: PhotoView(
        heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
        imageProvider: NetworkImage(imageUrl),
      ),
    );
  }
}
