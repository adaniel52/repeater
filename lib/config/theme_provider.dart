import 'package:flutter/material.dart';
import 'data.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.lightGreen,
        primaryContainer: Colors.lightGreen.shade400));

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.lightGreen,
        primaryContainer: Colors.lightGreen.shade800));

class ThemeProvider extends ChangeNotifier {
  ThemeData themeData = AppData.useDarkTheme ? darkTheme : lightTheme;

  Future<void> setTheme(ThemeData value) async {
    themeData = value;
    notifyListeners();
  }
}
