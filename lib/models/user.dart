import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/schedule_entry.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  int? _juzNumber;

  @HiveField(1)
  int? _rubuNumber;

  @HiveField(2)
  List<Juz> _juzs;

  @HiveField(3)
  DateTime _lastLoginTime;

  @HiveField(4)
  List<ScheduleEntry>? _schedules;

  @HiveField(5)
  String? _themeMode;

  @HiveField(6)
  int? _colorScheme;

  User({
    int? juzNumber,
    int? rubuNumber,
    List<Juz>? juzs,
    DateTime? lastLoginTime,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
  })  : _juzNumber = juzNumber,
        _rubuNumber = rubuNumber,
        _juzs = juzs ?? List.generate(30, (_) => Juz()),
        _lastLoginTime = lastLoginTime ??
            DateTime.now().subtract(
              const Duration(days: 1),
            ),
        _schedules = schedules,
        _themeMode = themeMode,
        _colorScheme = colorScheme;

  User copyWith({
    int? juzNumber,
    int? rubuNumber,
    List<Juz>? juzs,
    DateTime? lastLoginTime,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
  }) {
    return User(
      juzNumber: juzNumber ?? this.juzNumber,
      rubuNumber: rubuNumber ?? this.rubuNumber,
      juzs: juzs ?? this.juzs,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      schedules: schedules ?? this.schedules,
      themeMode: themeMode ?? this.themeMode,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  int? get juzNumber => _juzNumber;
  int? get rubuNumber => _rubuNumber;
  List<Juz> get juzs => _juzs;
  DateTime get lastLoginTime => _lastLoginTime;
  List<ScheduleEntry> get schedules => _schedules ?? [];
  String get themeMode => _themeMode ?? 'System';
  int get colorScheme => _colorScheme ?? Colors.teal.value;

  // List<ScheduleEntry> get manzilSchedules => schedules
  //     .where(
  //       (scheduleEntry) => scheduleEntry.reviewType == 'Manzil',
  //     )
  //     .toList();

  List<ScheduleEntry> getSchedulesByReviewType(String reviewType) => schedules
      .where(
        (scheduleEntry) => scheduleEntry.reviewType == reviewType,
      )
      .toList();

  DateTime getLatestStartDate(List<ScheduleEntry> schedules) {
    final latestStartDate = schedules
        .map((scheduleEntry) => scheduleEntry.startDate)
        .reduce((a, b) => a.isAfter(b) ? a : b);
    return latestStartDate;
  }
}
