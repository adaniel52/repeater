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
  }) async {
    final user = getUser()!.copyWith(
      juz: juz,
      rubu: rubu,
      juzs: juzs,
      themeMode: themeMode,
    );
    await createUser(user);
    notifyListeners();
  }

  Future<void> resetUser() async {
    User defaultUser = User();
    await createUser(defaultUser);
    notifyListeners();
  }

  Future<void> updateRubu(int juzNumber, int rubuNumber, Rubu rubu) async {
    User? user = getUser();

    Juz updatedJuz = user!.juzs[juzNumber - 1].copyWith(
      rubus: List.from(user.juzs[juzNumber - 1].rubus)..[rubuNumber - 1] = rubu,
    );

    List<Juz> updatedJuzs = List.from(user.juzs)..[juzNumber - 1] = updatedJuz;

    await updateUser(juzs: updatedJuzs);
  }

  // Future<void> updateRubus(int juzNumber, List<Rubu> rubus) async {
  //   User? user = getUser();

  //   Juz updatedJuz = user!.juzs[juzNumber - 1].copyWith(
  //     rubus: rubus,
  //   );

  //   List<Juz> updatedJuzs = List.from(user.juzs)..[juzNumber - 1] = updatedJuz;

  //   await updateUser(juzs: updatedJuzs);
  // }
}
