import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/rubu.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/notification_service.dart';
import 'package:repeater/services/schedule_service.dart';
import 'package:repeater/utils/date_time.dart';

class UserPreferences extends ChangeNotifier {
  static final UserPreferences _instance = UserPreferences._internal();
  UserPreferences._internal();
  factory UserPreferences() => _instance;

  static const _userKey = 'user';
  static late Box<User> _userBox;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(JuzAdapter());
    Hive.registerAdapter(RubuAdapter());
    Hive.registerAdapter(ScheduleEntryAdapter());
    // for reset purposes
    // Hive.deleteBoxFromDisk('userBox');
    _userBox = await Hive.openBox<User>('userBox');
  }

  Future<void> createUser(User user) async {
    await _userBox.put(_userKey, user);
    notifyListeners();
  }

  User? getUser() {
    return _userBox.get(_userKey);
  }

  Future<void> updateUser({
    int? juzNumber,
    int? rubuNumber,
    List<Juz>? juzs,
    DateTime? lastLoginTime,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
  }) async {
    final user = getUser()!.copyWith(
      juzNumber: juzNumber,
      rubuNumber: rubuNumber,
      juzs: juzs,
      lastLoginTime: lastLoginTime,
      schedules: schedules,
      themeMode: themeMode,
      colorScheme: colorScheme,
    );
    await createUser(user);
    notifyListeners();
  }

  Future<void> resetUser() async {
    await _userBox.delete(_userKey);
    notifyListeners();
  }

  Future<void> updateRubu(int juzNumber, int rubuNumber, Rubu rubu) async {
    final user = getUser()!;

    final updatedJuz = user.juzs[juzNumber - 1].copyWith(
      rubus: List.from(user.juzs[juzNumber - 1].rubus)..[rubuNumber - 1] = rubu,
    );

    final updatedJuzs = List<Juz>.from(user.juzs)..[juzNumber - 1] = updatedJuz;

    await updateUser(juzs: updatedJuzs);
  }

  Future<void> updateRubus(int juzNumber, List<Rubu> rubus) async {
    final user = getUser()!;

    final updatedJuz = user.juzs[juzNumber - 1].copyWith(
      rubus: rubus,
    );

    final updatedJuzs = List<Juz>.from(user.juzs)..[juzNumber - 1] = updatedJuz;

    await updateUser(juzs: updatedJuzs);
  }

  Future<void> logIn() async {
    final user = getUser()!;
    final now = DateTime.now();
    final currentSchedule = List<ScheduleEntry>.from(user.schedules);
    final newSchedules = <ScheduleEntry>[];

    for (final scheduleEntry in List<ScheduleEntry>.from(currentSchedule)) {
      if (isToday(scheduleEntry.startDate)) continue;
      if (scheduleEntry.startDate.isBefore(now)) {
        currentSchedule.remove(scheduleEntry);
      }
    }

    // if (user.lastLoginTime.day != now.day) {}

    final manzilSchedules = user.getSchedulesByReviewType('Manzil');
    final sabaqSchedules = user.getSchedulesByReviewType('Sabaq');
    final sabqiSchedules = user.getSchedulesByReviewType('Sabqi');

    if (manzilSchedules.isEmpty ||
        user.getLatestStartDate(manzilSchedules).isBefore(now)) {
      newSchedules.addAll(ScheduleService().scheduleManzil(user));
    }

    if (sabaqSchedules.isEmpty ||
        user.getLatestStartDate(sabaqSchedules).isBefore(now)) {
      newSchedules.addAll(ScheduleService().scheduleSabaq(user));
    }
    if (sabqiSchedules.isEmpty ||
        user.getLatestStartDate(sabqiSchedules).isBefore(now)) {
      newSchedules.addAll(ScheduleService().scheduleSabqi(user));
    }

    for (final scheduleEntry in newSchedules) {
      NotificationService().scheduleNotification(scheduleEntry);
    }

    currentSchedule.addAll(newSchedules);

    currentSchedule.sort((a, b) => a.startDate.compareTo(b.startDate));

    await updateUser(
      lastLoginTime: now,
      schedules: currentSchedule,
    );
  }
}
