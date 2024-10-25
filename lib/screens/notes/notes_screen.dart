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
      final data = json.decode(response.body);
      if (mounted) {
        setState(() {
          _notes = data['data'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = (width / 300).floor();
    final childWidth = (width -
            2 * Styles.screenSpacing -
            Styles.largeSpacing * (crossAxisCount - 1)) /
        crossAxisCount;
    final childHeight = childWidth * 9 / 16;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: (_notes.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: GridView.builder(
                padding: Styles.screenPadding,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: Styles.largeSpacing,
                  crossAxisSpacing: Styles.largeSpacing,
                  childAspectRatio: childWidth / (childHeight + 40),
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
            ),
    );
  }
}
