import 'package:flutter/material.dart';
import 'package:repeater/models/maqra.dart';

class MaqrasProgressIndicator extends StatelessWidget {
  final List<Maqra> maqras;
  const MaqrasProgressIndicator({
    super.key,
    required this.maqras,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: maqras.map((maqra) {
        return Expanded(
          child: Container(
            height: 4,
            color: maqra.isMemorized
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inversePrimary,
          ),
        );
      }).toList(),
    );
  }
}
