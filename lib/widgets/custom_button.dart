import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final void Function()? onPressed;
  final Widget child;

  const CustomButton({
    super.key,
    this.width = 400,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: Styles.borderRadius1,
          ),
        ),
        child: child,
      ),
    );
  }
}
