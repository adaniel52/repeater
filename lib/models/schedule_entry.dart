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
  Map<Juz, List<Rubu>?>? _reviewList;

  @HiveField(3)
  bool? _isCompleted;

  ScheduleEntry({
    DateTime? startDate,
    String? reviewType,
    Map<Juz, List<Rubu>?>? reviewList,
    bool? isCompleted,
  })  : _startDate = startDate ?? DateTime.now(),
        _reviewType = reviewType,
        _reviewList = reviewList,
        _isCompleted = isCompleted;

  DateTime get startDate => _startDate;
  String? get reviewType => _reviewType;
  Map<Juz, List<Rubu>?>? get reviewList => _reviewList;
  bool? get isCompleted => _isCompleted;
}
