import 'package:hive/hive.dart';

part 'rubu.g.dart';

@HiveType(typeId: 2)
class Rubu {
  @HiveField(0)
  bool? _isMemorized;

  @HiveField(1)
  bool? _isReviewed;

  Rubu({
    bool? isMemorized,
    bool? isReviewed,
  })  : _isMemorized = isMemorized,
        _isReviewed = isReviewed;

  Rubu copyWith({
    bool? isMemorized,
    bool? isReviewed,
  }) {
    return Rubu(
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
