import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';

class ChoiceChips extends StatelessWidget {
  final List<String> options;
  final String selected;
  final void Function(String) onSelected;
  const ChoiceChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Styles.smallSpacing,
      children: options.map((option) {
        return ChoiceChip(
          label: Text(option),
          selected: selected == option,
          onSelected: (_) {
            onSelected(option);
          },
        );
      }).toList(),
    );
  }
}
