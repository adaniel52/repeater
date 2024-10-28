import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/schedule_entry.dart';

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
  List<ScheduleEntry>? _schedules;

  @HiveField(4)
  String? _themeMode;

  @HiveField(5)
  int? _colorScheme;

  User({
    int? juz,
    int? rubu,
    List<Juz>? juzs,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
  })  : _juz = juz,
        _rubu = rubu,
        _juzs = juzs ?? List.generate(30, (_) => Juz()),
        _schedules = schedules,
        _themeMode = themeMode,
        _colorScheme = colorScheme;

  int? get juz => _juz;
  int? get rubu => _rubu;
  List<Juz> get juzs => _juzs;
  List<ScheduleEntry>? get schedules => _schedules;
  String get themeMode => _themeMode ?? 'System';
  int get colorScheme => _colorScheme ?? Colors.teal.value;

  User copyWith({
    int? juz,
    int? rubu,
    List<Juz>? juzs,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
  }) {
    return User(
      juz: juz ?? this.juz,
      rubu: rubu ?? this.rubu,
      juzs: juzs ?? this.juzs,
      schedules: schedules ?? this.schedules,
      themeMode: themeMode ?? this.themeMode,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }
}
