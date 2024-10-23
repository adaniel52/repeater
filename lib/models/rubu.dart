import 'package:hive/hive.dart';

part 'rubu.g.dart';

@HiveType(typeId: 2)
class Rubu {
  @HiveField(0)
  bool? _isStillRemembered;

  Rubu({bool? isStillRemembered}) : _isStillRemembered = isStillRemembered;

  bool get isStillRemembered => _isStillRemembered ?? false;

  set isStillRemembered(bool value) {
    _isStillRemembered = value;
  }
}
