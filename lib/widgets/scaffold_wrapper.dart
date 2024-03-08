import 'package:flutter/widgets.dart';

class ScaffoldWrapper extends StatelessWidget {
  final bool centered;
  final Widget child;
  const ScaffoldWrapper({super.key, required this.child, this.centered = true});

  @override
  Widget build(BuildContext context) {
    if (centered) {
      return SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: child,
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: child,
          ),
        ),
      );
    }
  }
}
