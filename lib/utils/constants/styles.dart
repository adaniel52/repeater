import 'package:flutter/material.dart';

class Styles {
  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: Colors.teal,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: primaryButtonStyle,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: headlineMedium,
    ),
    cardTheme: cardTheme,
  );

  static ThemeData darkTheme = ThemeData(
    colorSchemeSeed: Colors.teal,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headlineLarge: headlineLargeDark,
      headlineMedium: headlineMediumDark,
      headlineSmall: headlineSmallDark,
      bodyMedium: bodyMediumDark,
      bodySmall: bodySmallDark,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: primaryButtonStyleDark,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: headlineMediumDark,
    ),
    cardTheme: cardTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: Styles.mediumBorderRadius,
      ),
    ),
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

  static const double screenSpacing = 14;
  static const double smallSpacing = 4;
  static const double mediumSpacing = 8;
  static const double largeSpacing = 12;

  static const largeBorderRadius = BorderRadius.all(Radius.circular(16));
  static const mediumBorderRadius = BorderRadius.all(Radius.circular(12));
  static const smallBorderRadius = BorderRadius.all(Radius.circular(8));

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: textSecondaryColor,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16.0,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    color: textSecondaryColor,
  );

  static const TextStyle headlineLargeDark = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: textPrimaryDarkColor,
  );
  static const TextStyle headlineMediumDark = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: textPrimaryDarkColor,
  );
  static const TextStyle headlineSmallDark = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: textSecondaryDarkColor,
  );
  static const TextStyle bodyMediumDark = TextStyle(
    fontSize: 16.0,
  );
  static const TextStyle bodySmallDark = TextStyle(
    fontSize: 12.0,
    color: textSecondaryDarkColor,
  );

  static ButtonStyle primaryButtonStyle = FilledButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );

  static ButtonStyle primaryButtonStyleDark = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );

  static const CardTheme cardTheme = CardTheme(margin: EdgeInsets.all(0));
}
