import 'package:flutter/material.dart';

class SmallGap extends StatelessWidget {
  const SmallGap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 4,
      height: 4,
    );
  }
}

class MediumGap extends StatelessWidget {
  const MediumGap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 12,
      height: 12,
    );
  }
}

class LargeGap extends StatelessWidget {
  const LargeGap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
    );
  }
}
