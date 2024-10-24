import 'package:hive/hive.dart';
import 'package:repeater/models/rubu.dart';

part 'juz.g.dart';

@HiveType(typeId: 1)
class Juz {
  @HiveField(0)
  final List<Rubu> _rubus;

  Juz({
    List<Rubu>? rubus,
  }) : _rubus = rubus ?? List.generate(8, (_) => Rubu());

  Juz copyWith({
    List<Rubu>? rubus,
  }) {
    return Juz(
      rubus: rubus ?? this.rubus,
    );
  }

  List<Rubu> get rubus => _rubus;
  bool get isMemorized {
    for (var e in _rubus) {
      if (!e.isMemorized) {
        return false;
      }
    }
    return true;
  }

  set isMemorized(bool value) {
    for (var e in _rubus) {
      e.isMemorized = value;
    }
  }
}
