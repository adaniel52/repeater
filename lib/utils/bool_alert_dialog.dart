import 'package:flutter/material.dart';

Future<bool> showBoolAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required Widget falseText,
  required Widget trueText,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: falseText,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: trueText,
        ),
      ],
    ),
  );
}
