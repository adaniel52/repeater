import 'package:flutter/material.dart';

import 'my_container.dart';

class MyButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  const MyButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: MyContainer(
            child: Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold))));
  }
}
