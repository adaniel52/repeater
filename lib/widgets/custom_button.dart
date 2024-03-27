import 'package:flutter/material.dart';

import 'custom_container.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: CustomContainer(
            child: Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold))));
  }
}
