import 'package:hive/hive.dart';
import 'package:repeater/models/rubu.dart';

part 'juz.g.dart';

@HiveType(typeId: 1)
class Juz {
  @HiveField(0)
  final List<Rubu> _rubus;

  @HiveField(1)
  String? _fluency;

  Juz({
    List<Rubu>? rubus,
    String? fluency,
  })  : _rubus = rubus ?? List.generate(8, (_) => Rubu()),
        _fluency = fluency;

  List<Rubu> get rubus => _rubus;
  String get fluency => _fluency ?? 'None';
  bool get isMemorized {
    for (var e in _rubus) {
      if (!e.isMemorized) {
        return false;
      }
    }
    return true;
  }

  set fluency(String value) {
    _fluency = value;
  }

  Juz copyWith({
    List<Rubu>? rubus,
    String? fluency,
  }) {
    return Juz(
      rubus: rubus ?? this.rubus,
      fluency: fluency ?? this.fluency,
    );
  }
}
