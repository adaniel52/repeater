import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
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

  Future<void> updateUser({
    int? juz,
    int? rubu,
    List<Juz>? memorization,
    String? themeMode,
  }) async {
    final user = getUser()!.copyWith(
      juz: juz,
      rubu: rubu,
      memorization: memorization,
      themeMode: themeMode,
    );
    await createUser(user);
    notifyListeners();
  }

  User? getUser() {
    return _userBox.get('user');
  }

  Future<void> resetUser() async {
    User defaultUser = User();
    await createUser(defaultUser);
    notifyListeners();
  }
}
