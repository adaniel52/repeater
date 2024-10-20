import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class NotePhotoView extends StatefulWidget {
  final String imageUrl;
  const NotePhotoView({
    super.key,
    required this.imageUrl,
  });

  @override
  State<NotePhotoView> createState() => _NotePhotoViewState();
}

class _NotePhotoViewState extends State<NotePhotoView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Colors.white,
        // backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
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
        enablePanAlways: true,
        heroAttributes: PhotoViewHeroAttributes(tag: widget.imageUrl),
        imageProvider: NetworkImage(widget.imageUrl),
      ),
    );
  }
}
