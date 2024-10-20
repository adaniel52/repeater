import 'package:flutter/material.dart';

class AppStyles {
  // Theme data for light and dark mode
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.teal,
    textTheme: TextTheme(
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: primaryButtonStyle,
    // ),
    appBarTheme: AppBarTheme(
      titleTextStyle: headlineMedium,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.teal,
    textTheme: TextTheme(
      headlineLarge: headlineLargeDark,
      headlineMedium: headlineMediumDark,
      bodyMedium: bodyMediumDark,
      bodySmall: bodySmallDark,
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: primaryButtonStyleDark,
    // ),
    appBarTheme: AppBarTheme(
      titleTextStyle: headlineMediumDark,
    ),
  );

  // // Colors (Light Theme)
  // static const Color primaryColor = Color(0xFF0D47A1); // Deep Blue
  // static const Color secondaryColor = Color(0xFF1976D2); // Lighter Blue
  // static const Color accentColor = Color(0xFF42A5F5); // Even lighter blue
  // static const Color backgroundColor = Color(0xFFF3F4F6); // Light background
  // static const Color cardColor = Colors.white;

  // // Dark Mode Colors
  // static const Color primaryDarkColor = Color(0xFF1A237E); // Darker Blue
  // static const Color secondaryDarkColor =
  //     Color(0xFF3949AB); // Lighter Dark Blue
  // static const Color accentDarkColor = Color(0xFF8C9EFF); // Lighter Accent Blue
  // static const Color backgroundDarkColor = Color(0xFF121212); // Dark background
  // static const Color cardDarkColor = Color(0xFF1E1E1E); // Dark card background

  // Text Colors (Light Theme)
  static const Color textPrimaryColor = Color(0xFF212121); // Dark Grey
  static const Color textSecondaryColor = Color(0xFF757575); // Grey

  // Text Colors (Dark Mode)
  static const Color textPrimaryDarkColor =
      Color(0xFFE0E0E0); // Light Grey for text
  static const Color textSecondaryDarkColor = Color(0xFFBDBDBD); // Grey

  // Text Styles (Light Theme)
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

  // Text Styles (Dark Theme)
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

  // // Button Styles (Light Theme)
  // static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  //   // backgroundColor: primaryColor,
  //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  //   textStyle: TextStyle(color: Colors.white),
  // );

  // // Button Styles (Dark Theme)
  // static ButtonStyle primaryButtonStyleDark = ElevatedButton.styleFrom(
  //   // backgroundColor: primaryDarkColor,
  //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  //   textStyle: TextStyle(color: Colors.white),
  // );
}
