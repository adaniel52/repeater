import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  int? _juz;

  @HiveField(1)
  int? _rubu;

  @HiveField(2)
  List<Juz> _juzs;

  @HiveField(3)
  String? _themeMode;

  @HiveField(4)
  int? _colorScheme;

  User({
    int? juz,
    int? rubu,
    List<Juz>? juzs,
    String? themeMode,
    int? colorScheme,
  })  : _juz = juz,
        _rubu = rubu,
        _juzs = juzs ?? List.generate(30, (_) => Juz()),
        _themeMode = themeMode,
        _colorScheme = colorScheme;

  int? get juz => _juz;
  int? get rubu => _rubu;
  List<Juz> get juzs => _juzs;
  String get themeMode => _themeMode ?? 'System';
  int get colorScheme => _colorScheme ?? Colors.teal.value;

  User copyWith({
    int? juz,
    int? rubu,
    List<Juz>? juzs,
    String? themeMode,
    int? colorScheme,
  }) {
    return User(
      juz: juz ?? this.juz,
      rubu: rubu ?? this.rubu,
      juzs: juzs ?? this.juzs,
      themeMode: themeMode ?? this.themeMode,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }
}
