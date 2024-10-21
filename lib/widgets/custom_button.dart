import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final void Function()? onPressed;
  final Widget child;

  const CustomButton({
    super.key,
    this.width = double.infinity,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: FilledButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
