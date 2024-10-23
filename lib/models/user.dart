import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';

part 'user.g.dart';

const juzKey = 'juz';
const rubuKey = 'rubu';
const memorizationKey = 'memorization';
const themeModeKey = 'themeMode';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  int? _juz;

  @HiveField(1)
  int? _rubu;

  @HiveField(2)
  List<Juz>? _memorization;

  @HiveField(3)
  String? _themeMode;

  User({
    int? juz,
    int? rubu,
    List<Juz>? memorization,
    String? themeMode,
  })  : _juz = juz,
        _rubu = rubu,
        _memorization = memorization,
        _themeMode = themeMode;

  int? get juz => _juz;
  int? get rubu => _rubu;
  List<Juz>? get memorization => _memorization;
  String get themeMode => _themeMode ?? 'System';

  // String toJson() => json.encode({
  //       juzKey: _juz,
  //       rubuKey: _rubu,
  //       memorizationKey: _memorization,
  //       themeModeKey: mapThemeModeToString(_themeMode),
  //     });

  // factory User.fromJson(String source) {
  //   final data = json.decode(source);
  //   return User(
  //     juz: data[juzKey],
  //     rubu: data[rubuKey],
  //     memorization: data[memorizationKey],
  //     themeMode: mapStringtoThemeMode(data[themeModeKey]),
  //   );
  // }

  User copyWith({
    int? juz,
    int? rubu,
    List<Juz>? memorization,
    String? themeMode,
  }) {
    return User(
      juz: juz ?? this.juz,
      rubu: rubu ?? this.rubu,
      memorization: memorization ?? this.memorization,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
