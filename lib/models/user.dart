import 'dart:convert';

const juzKey = 'juz';
const juzProgressKey = 'juzProgress';

class User {
  int _juz;
  Map<String, String> _juzProgress;

  User({
    required int juz,
    required Map<String, String> juzProgress,
  })  : _juz = juz,
        _juzProgress = juzProgress;

  int get juz => _juz;
  Map<String, String> get juzProgress => _juzProgress;

  String toJson() => json.encode({
        juzKey: _juz,
        juzProgressKey: _juzProgress,
      });

  factory User.fromJson(String source) {
    final data = json.decode(source);
    return User(
      juz: data[juzKey],
      juzProgress: data[juzProgressKey],
    );
  }
}
