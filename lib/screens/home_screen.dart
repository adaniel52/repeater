import 'package:flutter/material.dart';
import 'package:repeater/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            Text(
              'Salam User',
              style: titleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
