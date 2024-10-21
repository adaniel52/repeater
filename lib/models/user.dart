import 'dart:convert';

const juzKey = 'juz';
const rubuKey = 'rubu';
const reviewProgressKey = 'reviewProgress';
const themeModeKey = 'themeMode';

class User {
  int _juz;
  int _rubu;
  Map _reviewProgress;
  String? _themeMode;

  User({
    required int juz,
    required int rubu,
    required Map reviewProgress,
    String? themeMode,
  })  : _juz = juz,
        _rubu = rubu,
        _reviewProgress = reviewProgress,
        _themeMode = themeMode;

  int get juz => _juz;
  int get rubu => _rubu;
  Map get reviewProgress => _reviewProgress;
  String? get themeMode => _themeMode;

  String toJson() => json.encode({
        juzKey: _juz,
        rubuKey: _rubu,
        reviewProgressKey: _reviewProgress,
        themeModeKey: _themeMode,
      });

  factory User.fromJson(String source) {
    final data = json.decode(source);
    return User(
        juz: data[juzKey] ?? 0,
        rubu: data[rubuKey] ?? 0,
        reviewProgress: data[reviewProgressKey] ?? {},
        themeMode: data[themeModeKey]);
  }

  User copyWith({
    int? juz,
    int? rubu,
    Map? reviewProgress,
    String? themeMode,
  }) {
    return User(
      juz: juz ?? this.juz,
      rubu: rubu ?? this.rubu,
      reviewProgress: reviewProgress ?? this.reviewProgress,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
