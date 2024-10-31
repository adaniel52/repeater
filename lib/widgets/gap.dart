import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';

class SmallGap extends StatelessWidget {
  const SmallGap({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: Styles.smallSpacing,
      height: Styles.smallSpacing,
    );
  }
}

class MediumGap extends StatelessWidget {
  const MediumGap({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: Styles.mediumSpacing,
      height: Styles.mediumSpacing,
    );
  }
}

class LargeGap extends StatelessWidget {
  const LargeGap({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: Styles.largeSpacing,
      height: Styles.largeSpacing,
    );
  }
}

class ScreenGap extends StatelessWidget {
  const ScreenGap({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: Styles.screenSpacing,
      height: Styles.screenSpacing,
    );
  }
}
