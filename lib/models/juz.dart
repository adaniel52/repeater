import 'package:hive/hive.dart';
import 'package:repeater/models/maqra.dart';

part 'juz.g.dart';

@HiveType(typeId: 1)
class Juz {
  @HiveField(0)
  List<Maqra> _maqras;

  Juz({
    List<Maqra>? maqras,
  }) : _maqras = maqras ?? List.generate(8, (_) => Maqra());

  Juz copyWith({
    List<Maqra>? maqras,
  }) {
    return Juz(
      maqras: maqras ?? this.maqras,
    );
  }

  List<Maqra> get maqras => _maqras;

  bool get isFullyMemorized => maqras.every((maqra) => maqra.isMemorized);
  bool get isPartiallyMemorized =>
      maqras.any((maqra) => maqra.isMemorized) && !isFullyMemorized;
  bool get isNotMemorized => maqras.every((maqra) => !maqra.isMemorized);

  bool get isFullyReviewed => maqras.every((maqra) => maqra.isReviewed);
  bool get isPartiallyReviewed =>
      maqras.any((maqra) => maqra.isReviewed) && !isFullyReviewed;
  bool get isNotReviewed => maqras.every((maqra) => !maqra.isReviewed);

  set isFullyMemorized(bool value) {
    for (final maqra in _maqras) {
      maqra.isMemorized = value;
    }
  }
}
