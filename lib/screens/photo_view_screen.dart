import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  final String title;
  final String image;

  const PhotoViewScreen({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Stack(
            children: [
              Hero(
                tag: '$image-tag',
                child: PhotoView(
                  imageProvider: AssetImage('assets/$image'),
                ),
              ),
              // IconButton with shadows for visual outline
              IconButton(
                padding: const EdgeInsets.all(16),
                onPressed: () {
                  Navigator.pop(context);
                },
                // Icon with shadows for visual outline
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  // Shadows for visual outline
                  shadows: [
                    Shadow(offset: Offset(1, 1)),
                    Shadow(offset: Offset(-1, -1)),
                    Shadow(offset: Offset(1, -1)),
                    Shadow(offset: Offset(-1, 1)),
                    Shadow(offset: Offset(2, 0)),
                    Shadow(offset: Offset(0, 2)),
                    Shadow(offset: Offset(-2, 0)),
                    Shadow(offset: Offset(0, -2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
