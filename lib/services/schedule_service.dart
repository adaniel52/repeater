import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/models/user.dart';

class ScheduleService {
  static final ScheduleService _instance = ScheduleService._internal();
  ScheduleService._internal();
  factory ScheduleService() => _instance;

  List<ScheduleEntry> scheduleManzil(User user) {
    final memorizedJuzs =
        user.juzs.where((juz) => juz.isFullyMemorized).toList();
    final schedules = user.schedules;
    final now = DateTime.now().copyWith(
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    for (var juz in memorizedJuzs) {
      final index = memorizedJuzs.indexOf(juz);
      final juzNumber = user.juzs.indexOf(juz) + 1;
      final startDate = now.add(Duration(days: index + 1));
      print(now);
      print(startDate);

      schedules.addAll(
        [
          ScheduleEntry(
            startDate: startDate.copyWith(hour: 6, minute: 30),
            reviewType: 'Manzil',
            juzNumber: juzNumber,
            rubuNumbers: [1, 2, 3, 4],
          ),
          ScheduleEntry(
            startDate: startDate.copyWith(hour: 17, minute: 0),
            reviewType: 'Manzil',
            juzNumber: juzNumber,
            rubuNumbers: [5, 6, 7, 8],
          ),
        ],
      );
    }

    return schedules;
  }
}
