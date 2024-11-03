import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/models/user.dart';

class ScheduleService {
  static final ScheduleService _instance = ScheduleService._internal();
  ScheduleService._internal();
  factory ScheduleService() => _instance;

  List<ScheduleEntry> scheduleManzil(User user) {
    final schedules = <ScheduleEntry>[];
    final memorizedJuzs = user.juzs
        .where((juz) => juz.isFullyMemorized || juz.isPartiallyMemorized)
        .toList();
    final now = DateTime.now().copyWith(
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    for (final juz in memorizedJuzs) {
      final index = memorizedJuzs.indexOf(juz);
      final juzNumber = user.juzs.indexOf(juz) + 1;
      final startDate = now.add(Duration(days: index + 1));

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

  List<ScheduleEntry> scheduleSabaq(User user) {
    final schedules = <ScheduleEntry>[];
    final juz = user.juzs
        .firstWhere((juz) => juz.isPartiallyMemorized || juz.isNotMemorized);
    final juzNumber = user.juzs.indexOf(juz) + 1;
    final rubu = juz.rubus.firstWhere((rubu) => !rubu.isMemorized);
    final rubuNumber = juz.rubus.indexOf(rubu) + 1;
    final now = DateTime.now().copyWith(
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    final scheduleEntry = ScheduleEntry(
      reviewType: 'Sabaq',
      juzNumber: juzNumber,
      rubuNumbers: [rubuNumber],
    );

    schedules.addAll([
      scheduleEntry.copyWith(
        startDate:
            now.add(const Duration(days: 1)).copyWith(hour: 8, minute: 30),
        fraction: '1 / 4',
      ),
      scheduleEntry.copyWith(
        startDate:
            now.add(const Duration(days: 1)).copyWith(hour: 20, minute: 0),
        fraction: '2 / 4',
      ),
      scheduleEntry.copyWith(
        startDate:
            now.add(const Duration(days: 2)).copyWith(hour: 8, minute: 30),
        fraction: '3 / 4',
      ),
      scheduleEntry.copyWith(
        startDate:
            now.add(const Duration(days: 2)).copyWith(hour: 20, minute: 0),
        fraction: '4 / 4',
      ),
    ]);

    return schedules;
  }
}
