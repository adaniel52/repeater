import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/note_card.dart';
import 'package:http/http.dart' as http;

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List _notes = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(
      Uri.parse('https://adaniel52.github.io/repeater/api/notes.json'),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        _notes = data['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    int crossAxisCount = (width / 300).floor();
    double childWidth =
        (width - 28 - 4 * (crossAxisCount - 1)) / crossAxisCount;
    double childHeight = childWidth * 9 / 16;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: GridView.builder(
        padding: Styles.screenPadding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: childWidth / (childHeight + 35),
        ),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final e = _notes[index];
          return NoteCard(
            imageUrl: e['imageUrl']!,
            title: e['title']!,
            contentUrl: e['contentUrl']!,
          );
        },
      ),
    );
  }
}
