import 'package:flutter/material.dart';
import 'package:repeater/models/rubu.dart';

class RubusProgressIndicator extends StatelessWidget {
  final List<Rubu> rubus;
  const RubusProgressIndicator({
    super.key,
    required this.rubus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: rubus.map((e) {
        return Expanded(
          child: Container(
            height: 4,
            color: e.isMemorized
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inversePrimary,
          ),
        );
      }).toList(),
    );
  }
}
