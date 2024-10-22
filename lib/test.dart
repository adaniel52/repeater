import 'dart:developer';

import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<Juz> reviewProgress = [];

  @override
  void initState() {
    super.initState();
    for (var i = 1; i <= 30; i++) {
      Map progress = {};
      for (var j = 1; j <= 8; j++) {
        progress[j.toString()] = false;
      }
      reviewProgress.add(Juz(rubu: Rubu(progress: progress)));
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var j = 1; j <= 30; j++) {
      log(reviewProgress[j - 1].rubu.progress.toString());
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {0: IntrinsicColumnWidth()},
          border: TableBorder.all(color: Colors.grey, width: 0.1),
          children: [
            TableRow(
              children: [
                const Text('Rubu',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ...List.generate(8, (index) {
                  return Center(
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              ],
            ),
            ...reviewProgress.asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;
              final progress = e.rubu.progress;

              return TableRow(children: [
                Text('Juz ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                ...progress.keys.map((juz) {
                  return Center(
                    child: Checkbox(
                      value: progress[juz],
                      onChanged: (value) {
                        setState(() {
                          progress[juz] = value ?? false; // Assign directly
                        });
                      },
                    ),
                  );
                }),
              ]);
            }),
          ],
        ),
      ),
    );
  }
}

class Juz {
  Rubu rubu;

  Juz({required this.rubu});
}

class Rubu {
  Map progress;

  Rubu({required this.progress});
}
