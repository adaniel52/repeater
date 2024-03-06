import 'package:flutter/material.dart';

Future<void> showCustomDialog(BuildContext context, String text) async {
  return showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: Text(text),
    ),
  );
}
