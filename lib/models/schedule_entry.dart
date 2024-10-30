import 'package:hive/hive.dart';

part 'schedule_entry.g.dart';

@HiveType(typeId: 3)
class ScheduleEntry {
  @HiveField(0)
  DateTime _startDate;

  @HiveField(1)
  String? _reviewType;

  @HiveField(2)
  int? _juzNumber;

  @HiveField(3)
  List<int> _rubus;

  @HiveField(4)
  bool? _isCompleted;

  ScheduleEntry({
    DateTime? startDate,
    String? reviewType,
    int? juzNumber,
    List<int>? rubus,
    bool? isCompleted,
  })  : _startDate = startDate ?? DateTime.now(),
        _reviewType = reviewType,
        _juzNumber = juzNumber,
        _rubus = rubus ?? List.generate(8, (index) => index + 1),
        _isCompleted = isCompleted;

  DateTime get startDate => _startDate;
  String? get reviewType => _reviewType;
  int get juzNumber => _juzNumber!;
  List<int> get rubus => _rubus;
  bool? get isCompleted => _isCompleted;
}
