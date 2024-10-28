import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';

class CenteredScrollableColumn extends StatelessWidget {
  final List<Widget> children;
  const CenteredScrollableColumn({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width - Styles.smallBreakpoint) / 2;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Styles.screenSpacing,
            horizontal: (horizontalPadding < Styles.screenSpacing)
                ? Styles.screenSpacing
                : horizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}
