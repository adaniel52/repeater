// enum InputType {
//   time,
// }

class Question {
  final String title;
  final String questionText;
  final String? inputType;
  dynamic answer;

  Question({
    required this.title,
    required this.questionText,
    this.inputType,
    this.answer,
  });
}
