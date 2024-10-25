import 'package:flutter/material.dart';

ThemeMode mapStringtoThemeMode(String? theme) {
  switch (theme) {
    case 'Light':
      return ThemeMode.light;
    case 'Dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

String mapThemeModeToString(ThemeMode? themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      return 'Light';
    case ThemeMode.dark:
      return 'Dark';
    default:
      return 'System';
  }
}
