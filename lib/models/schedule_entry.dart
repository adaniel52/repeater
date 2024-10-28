import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/rubu.dart';

part 'schedule_entry.g.dart';

@HiveType(typeId: 3)
class ScheduleEntry {
  @HiveField(0)
  final DateTime _startDate;

  @HiveField(1)
  final String _reviewType;

  @HiveField(2)
  final Map<Juz, List<Rubu>?> _reviewList;

  @HiveField(3)
  final bool? _isCompleted;

  ScheduleEntry({
    required DateTime startDate,
    required String reviewType,
    required Map<Juz, List<Rubu>> reviewList,
    bool? isCompleted,
  })  : _isCompleted = isCompleted,
        _reviewType = reviewType,
        _reviewList = reviewList,
        _startDate = startDate;

  DateTime get startDate => _startDate;
  String get reviewType => _reviewType;
  Map<Juz, List<Rubu>?> get reviewList => _reviewList;
  bool? get isCompleted => _isCompleted;
}