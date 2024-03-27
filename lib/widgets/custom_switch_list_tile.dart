import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatelessWidget {
  final String title;
  final double titleSize;
  final EdgeInsetsGeometry? contentPadding;
  final bool value;
  final void Function(bool)? onChanged;

  const CustomSwitchListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.contentPadding,
    this.titleSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      contentPadding: contentPadding,
      dense: true,
      title: Text(title, style: TextStyle(fontSize: titleSize)),
      value: value,
      onChanged: onChanged,
    );
  }
}
