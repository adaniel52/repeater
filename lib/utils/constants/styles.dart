import 'package:flutter/material.dart';

class Styles {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: buttonStyle,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: headlineLarge,
    ),
    cardTheme: cardTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      headlineLarge: headlineLargeDark,
      headlineMedium: headlineMediumDark,
      headlineSmall: headlineSmallDark,
      bodyMedium: bodyMediumDark,
      bodySmall: bodySmallDark,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: buttonStyleDark,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: headlineLargeDark,
    ),
    cardTheme: cardTheme,
  );

  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);

  static const Color textPrimaryDarkColor = Color(0xFFE0E0E0);
  static const Color textSecondaryDarkColor = Color(0xFFBDBDBD);

  static const noPadding = EdgeInsets.all(0);
  static const screenPadding = EdgeInsets.all(screenSpacing);
  static const smallPadding = EdgeInsets.all(smallSpacing);
  static const mediumPadding = EdgeInsets.all(mediumSpacing);
  static const largePadding = EdgeInsets.all(largeSpacing);

  static const double screenSpacing = 16;
  static const double smallSpacing = 4;
  static const double mediumSpacing = 8;
  static const double largeSpacing = 12;

  static const largeBorderRadius = BorderRadius.all(Radius.circular(16));
  static const mediumBorderRadius = BorderRadius.all(Radius.circular(12));
  static const smallBorderRadius = BorderRadius.all(Radius.circular(8));

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textSecondaryColor,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: textSecondaryColor,
  );

  static const TextStyle headlineLargeDark = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimaryDarkColor,
  );
  static const TextStyle headlineMediumDark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryDarkColor,
  );
  static const TextStyle headlineSmallDark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textSecondaryDarkColor,
  );
  static const TextStyle bodyMediumDark = TextStyle(
    fontSize: 16,
  );
  static const TextStyle bodySmallDark = TextStyle(
    fontSize: 12,
    color: textSecondaryDarkColor,
  );

  static ButtonStyle buttonStyle = FilledButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: const RoundedRectangleBorder(borderRadius: mediumBorderRadius),
  );

  static ButtonStyle buttonStyleDark = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: const RoundedRectangleBorder(borderRadius: mediumBorderRadius),
  );

  static const CardTheme cardTheme = CardTheme(margin: EdgeInsets.all(0));
}
