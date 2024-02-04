import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future<void> initPreferences() async {
  prefs = await SharedPreferences.getInstance();
}
