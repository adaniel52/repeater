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

  bool get isFullyMemorized => rubus.every((rubu) => rubu.isMemorized);
  bool get isPartiallyMemorized =>
      rubus.any((rubu) => rubu.isMemorized) && !isFullyMemorized;
  bool get isNotMemorized => rubus.every((rubu) => !rubu.isMemorized);

  bool get isFullyReviewed => rubus.every((rubu) => rubu.isReviewed);
  bool get isPartiallyReviewed =>
      rubus.any((rubu) => rubu.isReviewed) && !isFullyReviewed;
  bool get isNotReviewed => rubus.every((rubu) => !rubu.isReviewed);

  set isFullyMemorized(bool value) {
    for (var rubu in _rubus) {
      rubu.isMemorized = value;
    }
  }
}
