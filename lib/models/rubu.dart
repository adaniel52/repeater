import 'package:hive/hive.dart';

part 'rubu.g.dart';

@HiveType(typeId: 2)
class Rubu {
  @HiveField(0)
  bool? _isMemorized;

  Rubu({
    bool? isMemorized,
  }) : _isMemorized = isMemorized;

  Rubu copyWith({
    bool? isMemorized,
  }) {
    return Rubu(
      isMemorized: isMemorized ?? this.isMemorized,
    );
  }

  bool get isMemorized => _isMemorized ?? false;

  set isMemorized(bool value) {
    _isMemorized = value;
  }
}
