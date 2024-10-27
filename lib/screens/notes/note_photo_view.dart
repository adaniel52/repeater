import 'package:flutter/gestures.dart';
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
  late PhotoViewController _photoViewController;
  @override
  void initState() {
    super.initState();
    _photoViewController = PhotoViewController();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _photoViewController.dispose();
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
      body: Listener(
        // desktop zoom workaround - https://github.com/bluefireteam/photo_view/issues/481#issuecomment-2081412984
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            final delta = event.scrollDelta.dy;
            final controller = _photoViewController;
            final scale = controller.scale ?? 1.0;
            final newScale = scale - delta / 1000;
            controller.scale = newScale.clamp(0, double.infinity);
          }
        },
        child: PhotoView(
          controller: _photoViewController,
          enablePanAlways: true,
          heroAttributes: PhotoViewHeroAttributes(tag: widget.imageUrl),
          imageProvider: NetworkImage(widget.imageUrl),
        ),
      ),
    );
  }
}
