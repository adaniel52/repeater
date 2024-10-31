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
    for (var juz in memorizedJuzs) {
      final index = memorizedJuzs.indexOf(juz);
      final juzNumber = user.juzs.indexOf(juz) + 1;
      schedules.add(
        ScheduleEntry(
          startDate: DateTime.now().add(Duration(days: index)),
          reviewType: 'Manzil',
          juzNumber: juzNumber,
        ),
      );
    }
    return schedules;
  }
}
