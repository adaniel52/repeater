import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';

class ChoiceChips extends StatefulWidget {
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
  State<ChoiceChips> createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Styles.smallSpacing,
      children: widget.options.map((e) {
        return ChoiceChip(
          label: Text(e),
          selected: widget.selected == e,
          onSelected: (_) {
            widget.onSelected(e);
          },
        );
      }).toList(),
    );
  }
}
