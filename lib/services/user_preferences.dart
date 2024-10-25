import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/rubu.dart';
import 'package:repeater/models/user.dart';

class UserPreferences extends ChangeNotifier {
  static final UserPreferences _instance = UserPreferences._internal();
  late Box<User> _userBox;

  UserPreferences._internal();

  factory UserPreferences() => _instance;

  Future<void> init() async {
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
    String? themeMode,
    int? colorScheme,
  }) async {
    final user = getUser()!.copyWith(
      juz: juz,
      rubu: rubu,
      juzs: juzs,
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
}
