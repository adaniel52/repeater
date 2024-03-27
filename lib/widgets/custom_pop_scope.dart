import 'package:flutter/material.dart';

class MyPopScope extends StatelessWidget {
  final Widget child;
  const MyPopScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        // onPopInvoked: (value) async {
        // if (value) {
        //   return;
        // }

        // bool result = await AppData.showExitConfirmationDialog(context);
        // if (!context.mounted) return;
        // if (result) {
        //   Navigator.of(context).pop();
        // },
        child: child);
  }
}
