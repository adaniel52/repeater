import 'package:flutter/material.dart';
import 'shared_preferences.dart';

class UserData {
  static bool isNew = prefs.getBool('new') ?? true;
  static bool hasKhatam = prefs.getBool('khatam') ?? false;
  static bool isFasting = prefs.getBool('fasting') ?? false;
  static int page = prefs.getInt('page') ?? 0;
  static int juz = (page == 0) ? 0 : AppData.calcJuz(page);
}

class AppData {
  static bool useDarkTheme = prefs.getBool('darkTheme') ?? true;
  static bool shouldRescheduleNotifications = true;
  static int lastIsFastingPrompt = 0;
  static DateTime now = DateTime.now();
  static List timetable = [];

  static int calcJuz(int page) {
    int temp = ((page - 1) / 20).ceil();
    return (temp < 1) ? 1 : (temp > 30 ? 30 : temp);
  }

  static int calcRelativePage(int page) {
    return (page < 1) ? 1 : (page > 604 ? 604 : page);
  }

  static int calcRelativeJuz(int juz) {
    return (juz < 1) ? 1 : (juz > 604 ? 604 : juz);
  }

  static void updateTimetable() {
    List timetable = [];
    if (!UserData.hasKhatam) {
      if (!UserData.isFasting) {
        timetable = hafizTable;
      } else {
        timetable = hafizFastingTable;
      }
    } else {
      if (!UserData.isFasting) {
        timetable = khatamTable;
      } else {
        timetable = khatamFastingTable;
      }
    }
    AppData.timetable = timetable;
  }

  static Future<void> resetData() async {
    UserData.isNew = true;
    UserData.isFasting = false;
    UserData.hasKhatam = false;
    AppData.shouldRescheduleNotifications = true;
    UserData.page = 0;
    UserData.juz = 0;
    AppData.lastIsFastingPrompt = 0;
    await prefs.setBool('new', true);
    await prefs.setBool('fasting', false);
    await prefs.setBool('khatam', false);
    await prefs.setInt('page', 0);
  }

  static Future<bool> showExitConfirmationDialog(BuildContext context) async {
    bool result = await showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              title: const Text('Confirm Exit',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Text('Are you sure to exit?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child:
                        const Text('Exit', style: TextStyle(color: Colors.red)))
              ],
            ));
    return result;
  }

  static showCustomDialog(
      {required BuildContext context,
      required String title,
      Widget? content,
      List<Widget>? actions}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              title: Text(title.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              content: content,
              actions: actions,
            ));
  }
}

enum FormType { signUp, edit }

enum MurajaahType { prasabaq, sabaq, sabqi, usbuiyyah, qadimah, mukhtar }

class TimetableEntry {
  MurajaahType type;
  TimeOfDay time;
  List<int> weekdays;

  TimetableEntry(
      {required this.type, required this.time, required this.weekdays});
}

class NotesMenuItem {
  IconData icon;
  String title;
  List list;

  NotesMenuItem({required this.icon, required this.title, required this.list});
}

class NotesItem {
  String title;
  String image;

  NotesItem({required this.title, required this.image});
}

class NotesData {
  static final List notesMenuItems = [
    NotesMenuItem(icon: Icons.rule, title: 'Tajweed', list: tajweedNotesItem),
    NotesMenuItem(
        icon: Icons.event_repeat, title: 'Murajaah', list: murajaahNotesItem),
    //NotesMenuItem(icon: Icons.trending_up, title: 'Motivation', list: [])
  ];

  static final List tajweedNotesItem = [
    NotesItem(title: 'Nun Sakinah', image: 'nun-sakinah.png'),
    NotesItem(title: 'Mim Sakinah', image: 'mim-sakinah.png'),
    NotesItem(title: 'Waqaf Mark', image: 'waqaf-mark.png'),
    NotesItem(title: 'Alif Lam', image: 'alif-lam.png'),
    NotesItem(title: 'Mad Muttasil & Munfasil', image: 'mad-wajib-jaiz.png'),
    NotesItem(title: 'Mad Arid', image: 'mad-arid.png'),
    NotesItem(title: 'Mad Silah', image: 'mad-silah.png'),
  ];

  static final List murajaahNotesItem = [
    NotesItem(title: 'Murajaah Type', image: 'murajaah-type.png'),
    NotesItem(title: 'Memorise Tips #1', image: 'memorise-tips.png'),
    NotesItem(title: 'Memorise Tips #2', image: 'memorise-tips-2.png'),
  ];
}

final List hafizTable = [
  TimetableEntry(
      type: MurajaahType.prasabaq,
      time: const TimeOfDay(hour: 5, minute: 30),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.qadimah,
      time: const TimeOfDay(hour: 6, minute: 30),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.sabqi,
      time: const TimeOfDay(hour: 7, minute: 30),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 7, minute: 30),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.usbuiyyah,
      time: const TimeOfDay(hour: 8, minute: 0),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.sabaq,
      time: const TimeOfDay(hour: 8, minute: 30),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.prasabaq,
      time: const TimeOfDay(hour: 10, minute: 0),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 14, minute: 30),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.prasabaq,
      time: const TimeOfDay(hour: 19, minute: 0),
      weekdays: [1, 2, 3, 4, 5, 6, 7])
];

final List hafizFastingTable = [
  TimetableEntry(
      type: MurajaahType.prasabaq,
      time: const TimeOfDay(hour: 5, minute: 45),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.qadimah,
      time: const TimeOfDay(hour: 6, minute: 30),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 7, minute: 30),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.sabqi,
      time: const TimeOfDay(hour: 7, minute: 40),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.usbuiyyah,
      time: const TimeOfDay(hour: 8, minute: 0),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.sabaq,
      time: const TimeOfDay(hour: 8, minute: 30),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.prasabaq,
      time: const TimeOfDay(hour: 10, minute: 0),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 14, minute: 30),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.prasabaq,
      time: const TimeOfDay(hour: 19, minute: 30),
      weekdays: [1, 2, 3, 4, 5, 6, 7])
];

final List khatamTable = [
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 5, minute: 0),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 7, minute: 30),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.qadimah,
      time: const TimeOfDay(hour: 7, minute: 40),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.qadimah,
      time: const TimeOfDay(hour: 10, minute: 0),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 14, minute: 30),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 19, minute: 0),
      weekdays: [1, 2, 3, 4, 7])
];

final List khatamFastingTable = [
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 5, minute: 45),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.qadimah,
      time: const TimeOfDay(hour: 6, minute: 30),
      weekdays: [1, 2, 3, 4, 7]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 7, minute: 30),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.qadimah,
      time: const TimeOfDay(hour: 10, minute: 0),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 14, minute: 30),
      weekdays: [5, 6]),
  TimetableEntry(
      type: MurajaahType.mukhtar,
      time: const TimeOfDay(hour: 19, minute: 30),
      weekdays: [1, 2, 3, 4, 7])
];
