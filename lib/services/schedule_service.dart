class ScheduleService {
//   DateTime startDate;

//   ScheduleService(this.startDate);

//   List<List<int>> newJuzMemorizationSchedule = [
//     [1],
//     [1, 2],
//     [1, 2, 3],
//     [1, 2, 3, 4],
//     [5],
//     [5, 6],
//     [5, 6, 7],
//     [5, 6, 7, 8],
//     [1, 2, 3, 4, 5, 6, 7, 8],
//   ];

//   int getCurrentDay() {
//     final currentDate = DateTime.now();
//     final difference = currentDate.difference(startDate).inDays + 1;
//     return (difference > 9) ? 9 : difference;
//   }

//   List<int> getTodaySchedule() {
//     final day = getCurrentDay();
//     return newJuzMemorizationSchedule[day - 1];
//   }
}
