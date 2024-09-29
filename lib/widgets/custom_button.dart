import 'package:flutter/material.dart';
import 'package:repeater/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String labelText;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
        ),
        child: Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
