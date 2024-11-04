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
  List<int> _rubuNumbers;

  @HiveField(4)
  String? _fraction;

  @HiveField(5)
  bool? _isCompleted;

  ScheduleEntry({
    DateTime? startDate,
    String? reviewType,
    int? juzNumber,
    List<int>? rubuNumbers,
    String? fraction,
    bool? isCompleted,
  })  : _startDate = startDate ?? DateTime.now(),
        _reviewType = reviewType,
        _juzNumber = juzNumber,
        _rubuNumbers = rubuNumbers ?? List.generate(8, (index) => index + 1),
        _fraction = fraction,
        _isCompleted = isCompleted;

  ScheduleEntry copyWith({
    DateTime? startDate,
    String? reviewType,
    int? juzNumber,
    List<int>? rubuNumbers,
    String? fraction,
    bool? isCompleted,
  }) {
    return ScheduleEntry(
      startDate: startDate ?? this.startDate,
      reviewType: reviewType ?? this.reviewType,
      juzNumber: juzNumber ?? this.juzNumber,
      rubuNumbers: rubuNumbers ?? this.rubuNumbers,
      fraction: fraction ?? this.fraction,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  DateTime get startDate => _startDate;
  String? get reviewType => _reviewType;
  int get juzNumber => _juzNumber!;
  List<int> get rubuNumbers => _rubuNumbers;
  String? get fraction => _fraction;
  bool get isCompleted => _isCompleted ?? false;

  set isCompleted(bool value) {
    isCompleted = value;
  }
}