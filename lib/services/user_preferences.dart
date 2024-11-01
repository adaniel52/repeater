import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/rubu.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/schedule_service.dart';

class UserPreferences extends ChangeNotifier {
  static final UserPreferences _instance = UserPreferences._internal();
  UserPreferences._internal();
  factory UserPreferences() => _instance;

  late Box<User> _userBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(JuzAdapter());
    Hive.registerAdapter(RubuAdapter());
    Hive.registerAdapter(ScheduleEntryAdapter());
    // for reset purposes
    // Hive.deleteBoxFromDisk('userBox');
    _userBox = await Hive.openBox<User>('userBox');
  }

  Future<void> createUser(User user) async {
    await _userBox.put('user', user);
    notifyListeners();
  }

  User? getUser() {
    return _userBox.get('user');
  }

  Future<void> updateUser({
    int? juz,
    int? rubu,
    List<Juz>? juzs,
    DateTime? lastLoginTime,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
  }) async {
    final user = getUser()!.copyWith(
      juz: juz,
      rubu: rubu,
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
    await _userBox.delete('user');
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
    final schedules = <ScheduleEntry>[];

    if (user.lastLoginTime.day != now.day) {
      if (user.manzilSchedules.isEmpty ||
          user.getLatestStartDate(user.manzilSchedules).isBefore(now)) {
        schedules.addAll(ScheduleService().scheduleManzil(user));
      }
    }

    await updateUser(
      lastLoginTime: now,
      schedules: schedules,
    );

    debugPrint('login');
  }
}
