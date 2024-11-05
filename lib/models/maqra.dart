import 'package:hive/hive.dart';

part 'maqra.g.dart';

@HiveType(typeId: 2)
class Maqra {
  @HiveField(0)
  bool? _isMemorized;

  @HiveField(1)
  bool? _isReviewed;

  Maqra({
    bool? isMemorized,
    bool? isReviewed,
  })  : _isMemorized = isMemorized,
        _isReviewed = isReviewed;

  Maqra copyWith({
    bool? isMemorized,
    bool? isReviewed,
  }) {
    return Maqra(
      isMemorized: isMemorized ?? this.isMemorized,
      isReviewed: isReviewed ?? this.isReviewed,
    );
  }

  bool get isMemorized => _isMemorized ?? false;
  bool get isReviewed => _isReviewed ?? false;

  set isMemorized(bool value) {
    _isMemorized = value;
  }

  set isReviewed(bool value) {
    _isReviewed = value;
  }
}
