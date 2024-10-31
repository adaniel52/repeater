import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String data;
  const SectionTitle(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        data,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
