import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_video/flutter_html_video.dart';
import 'package:repeater/screens/notes/note_photo_view.dart';
import 'package:repeater/utils/constants.dart';
import 'package:http/http.dart' as http;

class NoteDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String contentUrl;
  const NoteDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.contentUrl,
  });

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  String htmlContent = '';

  @override
  void initState() {
    super.initState();
    _fetchContent();
  }

  Future<void> _fetchContent() async {
    final response = await http.get(Uri.parse(widget.contentUrl));
    if (response.statusCode == 200) {
      var data = response.body;
      setState(() {
        htmlContent = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
                                NotePhotoView(imageUrl: widget.imageUrl),
                          ),
                        );
                      },
                      child: Hero(
                        tag: widget.imageUrl,
                        child: ClipRRect(
                          borderRadius: defaultBorderRadius,
                          child: Image(
                            image: NetworkImage(widget.imageUrl),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    // Text(widget.contentUrl)
                    Html(
                      data: htmlContent,
                      extensions: [
                        VideoHtmlExtension(),
                      ],
                    ),
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
