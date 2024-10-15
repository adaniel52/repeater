import 'dart:convert';

const juzKey = 'juz';
const rubuKey = 'rubu';
const reviewProgressKey = 'reviewProgress';

class User {
  int _juz;
  int _rubu;
  Map _reviewProgress;

  User({
    required int juz,
    required int rubu,
    required Map reviewProgress,
  })  : _juz = juz,
        _rubu = rubu,
        _reviewProgress = reviewProgress;

  int get juz => _juz;
  int get rubu => _rubu;
  Map get reviewProgress => _reviewProgress;

  String toJson() => json.encode({
        juzKey: _juz,
        rubuKey: _rubu,
        reviewProgressKey: _reviewProgress,
      });

  factory User.fromJson(String source) {
    final data = json.decode(source);
    return User(
      juz: data[juzKey],
      rubu: data[rubuKey],
      reviewProgress: data[reviewProgressKey],
    );
  }
}
