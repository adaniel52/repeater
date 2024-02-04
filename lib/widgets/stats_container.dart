import 'package:flutter/material.dart';

class StatsContainer extends StatelessWidget {
  final String prop;
  final dynamic value;
  const StatsContainer({super.key, required this.prop, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).textTheme.bodyLarge!.color ??
                    Colors.black),
            borderRadius: BorderRadius.circular(8)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('$prop:', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('$value')
        ]));
  }
}
