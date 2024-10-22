import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {0: FixedColumnWidth(100)},
        border: TableBorder.all(color: Colors.grey, width: .1),
        children: [
          TableRow(
            children: [
              Text('Rubu', style: TextStyle(fontWeight: FontWeight.bold)),
              ...List.generate(8, (e) {
                return Center(
                  child: Text(
                    (e + 1).toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ],
          ),
          TableRow(children: [
            Text('Juz', style: TextStyle(fontWeight: FontWeight.bold)),
            ...List.generate(8, (e) {
              return Center(
                child: Checkbox(value: true, onChanged: (_) {}),
              );
            }),
          ]),
        ],
      ),
    );
  }
}
