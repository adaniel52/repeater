import 'package:flutter/material.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences extends ChangeNotifier {
  static final UserPreferences _instance = UserPreferences._internal();
  SharedPreferences? _preferences;
  UserPreferences._internal();

  factory UserPreferences() => _instance;

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  SharedPreferences? get prefs => _preferences;

  Future<void> createUser(User user) async {
    if (_preferences == null) return;
    await _preferences!.setString('user', user.toJson());
    notifyListeners();
  }

  Future<void> updateUser({
    int? juz,
    int? rubu,
    List<Juz>? memorization,
    ThemeMode? themeMode,
  }) async {
    if (_preferences == null) return;
    final user = getUser()!.copyWith(
      juz: juz,
      rubu: rubu,
      memorization: memorization,
      themeMode: themeMode,
    );
    await _preferences!.setString('user', user.toJson());
    notifyListeners();
  }

  User? getUser() {
    if (_preferences == null) return null;
    String? userJson = _preferences!.getString('user');
    if (userJson == null) return null;
    return User.fromJson(userJson);
  }

  Future<void> resetUser() async {
    User defaultUser = User();
    await createUser(defaultUser);
    notifyListeners();
  }
}
