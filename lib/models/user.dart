import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  int? _juz;

  @HiveField(1)
  int? _rubu;

  @HiveField(2)
  List<Juz> _juzs;

  @HiveField(3)
  String? _themeMode;

  User({
    int? juz,
    int? rubu,
    List<Juz>? juzs,
    String? themeMode,
  })  : _juz = juz,
        _rubu = rubu,
        _juzs = juzs ?? List.generate(30, (_) => Juz()),
        _themeMode = themeMode;

  int? get juz => _juz;
  int? get rubu => _rubu;
  List<Juz> get juzs => _juzs;
  String get themeMode => _themeMode ?? 'System';

  User copyWith({
    int? juz,
    int? rubu,
    List<Juz>? juzs,
    String? themeMode,
  }) {
    return User(
      juz: juz ?? this.juz,
      rubu: rubu ?? this.rubu,
      juzs: juzs ?? this.juzs,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
