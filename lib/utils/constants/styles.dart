import 'package:flutter/material.dart';

class Styles {
  static final lightTheme = ThemeData(
    // web status bar color flickering workaround
    primaryColor: Colors.black,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    textTheme: TextTheme(
      titleLarge: titleLarge,
      titleMedium: titleMedium,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    textTheme: TextTheme(
      titleLarge: titleLarge,
      titleMedium: titleMedium,
    ),
  );

  static const double smallBreakpoint = 480;
  static const double largeBreakpoint = 768;

  static const double screenSpacing = 16;
  static const double smallSpacing = 4;
  static const double mediumSpacing = 8;
  static const double largeSpacing = 12;

  static const noPadding = EdgeInsets.all(0);
  static const screenPadding = EdgeInsets.all(screenSpacing);
  static const smallPadding = EdgeInsets.all(smallSpacing);
  static const mediumPadding = EdgeInsets.all(mediumSpacing);
  static const largePadding = EdgeInsets.all(largeSpacing);

  static const largeBorderRadius = BorderRadius.all(Radius.circular(16));
  static const mediumBorderRadius = BorderRadius.all(Radius.circular(12));
  static const smallBorderRadius = BorderRadius.all(Radius.circular(8));

  static const greyText = Color(0xFF757575);

  static TextStyle titleLarge = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
