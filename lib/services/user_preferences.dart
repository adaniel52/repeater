import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/maqra.dart';
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
    Hive.registerAdapter(MaqraAdapter());
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
    int? maqraNumber,
    List<Juz>? juzs,
    DateTime? lastLoginTime,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
  }) async {
    final user = getUser()!.copyWith(
      juzNumber: juzNumber,
      maqraNumber: maqraNumber,
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

  Future<void> setKhatam() async {
    final user = getUser()!;
    final newUser = User(
      juzs: user.juzs,
      lastLoginTime: user.lastLoginTime,
      schedules: user.schedules,
      themeMode: user.themeMode,
      colorScheme: user.colorScheme,
    );
    await createUser(newUser);
    notifyListeners();
  }

  Future<void> updateMaqra(int juzNumber, int maqraNumber, Maqra maqra) async {
    final user = getUser()!;

    final updatedJuz = user.juzs[juzNumber - 1].copyWith(
      maqras: List.from(user.juzs[juzNumber - 1].maqras)
        ..[maqraNumber - 1] = maqra,
    );

    final updatedJuzs = List<Juz>.from(user.juzs)..[juzNumber - 1] = updatedJuz;

    await updateUser(juzs: updatedJuzs);
  }

  Future<void> updateMaqras(int juzNumber, List<Maqra> maqras) async {
    final user = getUser()!;

    final updatedJuz = user.juzs[juzNumber - 1].copyWith(
      maqras: maqras,
    );

    final updatedJuzs = List<Juz>.from(user.juzs)..[juzNumber - 1] = updatedJuz;

    await updateUser(juzs: updatedJuzs);
  }

  Future<void> logIn({
    bool shouldReschedule = false,
  }) async {
    if (shouldReschedule) await updateUser(schedules: []);

    final user = getUser()!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final currentSchedule = List<ScheduleEntry>.from(user.schedules);
    final newSchedules = <ScheduleEntry>[];

    final manzilSchedules = user.getSchedulesByReviewType('Manzil');
    final sabaqSchedules = user.getSchedulesByReviewType('Sabaq');
    final sabqiSchedules = user.getSchedulesByReviewType('Sabqi');

    if (manzilSchedules.isEmpty ||
        user.getLatestStartDate(manzilSchedules).isBefore(tomorrow)) {
      newSchedules.addAll(ScheduleService().scheduleManzil(user));
    }

    if (sabaqSchedules.isEmpty ||
        user.getLatestStartDate(sabaqSchedules).isBefore(today)) {
      newSchedules.addAll(ScheduleService().scheduleSabaq(user));
    }
    if (sabqiSchedules.isEmpty ||
        user.getLatestStartDate(sabqiSchedules).isBefore(tomorrow)) {
      newSchedules.addAll(ScheduleService().scheduleSabqi(user));
    }

    for (final scheduleEntry in newSchedules) {
      NotificationService().scheduleNotification(scheduleEntry);
    }

    for (final scheduleEntry in List<ScheduleEntry>.from(currentSchedule)) {
      if (isToday(scheduleEntry.startDate)) continue;
      if (scheduleEntry.startDate.isBefore(today)) {
        currentSchedule.remove(scheduleEntry);
      }
    }

    currentSchedule.addAll(newSchedules);
    currentSchedule.sort((a, b) => a.startDate.compareTo(b.startDate));

    await updateUser(
      lastLoginTime: now,
      schedules: currentSchedule,
    );
  }
}
