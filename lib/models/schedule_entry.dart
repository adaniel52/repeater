import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/rubu.dart';

part 'schedule_entry.g.dart';

@HiveType(typeId: 3)
class ScheduleEntry {
  @HiveField(0)
  DateTime _startDate;

  @HiveField(1)
  String? _reviewType;

  @HiveField(2)
  Juz? _juz;

  @HiveField(3)
  List<Rubu> _rubus;

  @HiveField(4)
  bool? _isCompleted;

  ScheduleEntry({
    DateTime? startDate,
    String? reviewType,
    Juz? juz,
    List<Rubu>? rubus,
    bool? isCompleted,
  })  : _startDate = startDate ?? DateTime.now(),
        _reviewType = reviewType,
        _juz = juz,
        _rubus = rubus ?? juz!.rubus,
        _isCompleted = isCompleted;

  DateTime get startDate => _startDate;
  String? get reviewType => _reviewType;
  Juz get juz => _juz!;
  List<Rubu> get rubus => _rubus;
  bool? get isCompleted => _isCompleted;
}
