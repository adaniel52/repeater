import 'package:flutter/material.dart';

class Styles {
  static final lightTheme = ThemeData(
    // web status bar color flickering workaround
    primaryColor: Colors.black,
    textTheme: const TextTheme(
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    filledButtonTheme: filledButtonTheme,
    appBarTheme: const AppBarTheme(
      titleTextStyle: headlineLarge,
    ),
    cardTheme: cardTheme,
    scrollbarTheme: scrollbarTheme,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      headlineLarge: headlineLargeDark,
      headlineMedium: headlineMediumDark,
      headlineSmall: headlineSmallDark,
      bodyMedium: bodyMediumDark,
      bodySmall: bodySmallDark,
    ),
    filledButtonTheme: filledButtonTheme,
    appBarTheme: const AppBarTheme(
      titleTextStyle: headlineLargeDark,
    ),
    cardTheme: cardTheme,
    scrollbarTheme: scrollbarTheme,
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

  static const textPrimaryColor = Color(0xFF212121);
  static const textSecondaryColor = Color(0xFF757575);
  static const textPrimaryDarkColor = Color(0xFFE0E0E0);
  static const textSecondaryDarkColor = Color(0xFFBDBDBD);

  static const headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  static const headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  static const headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textSecondaryColor,
  );
  static const bodyMedium = TextStyle(
    fontSize: 16,
  );
  static const bodySmall = TextStyle(
    fontSize: 12,
    color: textSecondaryColor,
  );

  static const headlineLargeDark = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimaryDarkColor,
  );
  static const headlineMediumDark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryDarkColor,
  );
  static const headlineSmallDark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textSecondaryDarkColor,
  );
  static const bodyMediumDark = TextStyle(
    fontSize: 16,
  );
  static const bodySmallDark = TextStyle(
    fontSize: 12,
    color: textSecondaryDarkColor,
  );

  static final filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
      shape: const RoundedRectangleBorder(borderRadius: mediumBorderRadius),
    ),
  );

  static const cardTheme = CardTheme(margin: EdgeInsets.all(0));

  static const scrollbarTheme = ScrollbarThemeData(
    interactive: true,
  );
}
