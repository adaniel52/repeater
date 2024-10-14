import 'dart:convert';

const juzKey = 'juz';

class User {
  int _juz;

  User({
    required int juz,
  }) : _juz = juz;

  int get juz => _juz;

  String toJson() => json.encode({
        juzKey: _juz,
      });

  factory User.fromJson(String source) {
    final data = json.decode(source);
    return User(
      juz: data[juzKey],
    );
  }
}
