import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/utils/theme_mode.dart';

const juzKey = 'juz';
const rubuKey = 'rubu';
const memorizationKey = 'memorization';
const themeModeKey = 'themeMode';

class User {
  int? _juz;
  int? _rubu;
  List<Juz>? _memorization;
  ThemeMode? _themeMode;

  User({
    int? juz,
    int? rubu,
    List<Juz>? memorization,
    ThemeMode? themeMode,
  })  : _juz = juz,
        _rubu = rubu,
        _memorization = memorization,
        _themeMode = themeMode;

  int? get juz => _juz;
  int? get rubu => _rubu;
  List<Juz>? get memorization => _memorization;
  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;

  String toJson() => json.encode({
        juzKey: _juz,
        rubuKey: _rubu,
        memorizationKey: _memorization,
        themeModeKey: mapThemeModeToString(_themeMode),
      });

  factory User.fromJson(String source) {
    final data = json.decode(source);
    return User(
      juz: data[juzKey],
      rubu: data[rubuKey],
      memorization: data[memorizationKey],
      themeMode: mapStringtoThemeMode(data[themeModeKey]),
    );
  }

  User copyWith({
    int? juz,
    int? rubu,
    List<Juz>? memorization,
    ThemeMode? themeMode,
  }) {
    return User(
      juz: juz ?? this.juz,
      rubu: rubu ?? this.rubu,
      memorization: memorization ?? this.memorization,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
