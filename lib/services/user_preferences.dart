import 'package:repeater/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> _getPreferences() async =>
      _preferences ?? await SharedPreferences.getInstance();

  static Future<void> setUser(User user) async {
    final prefs = await _getPreferences();
    await prefs.setString('user', user.toJson());
  }

  static Future<User?> getUser() async {
    final prefs = await _getPreferences();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      return User.fromJson(userJson);
    }
    return null;
  }

  static Future<void> resetUser() async {
    await setUser(
      User(
        juz: 0,
        juzProgress: {'1': 'None'},
      ),
    );
  }
}
