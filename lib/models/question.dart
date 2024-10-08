enum InputType {
  time,
}

class Question {
  final String title;
  final String questionText;
  final String inputType;

  Question({
    required this.title,
    required this.questionText,
    required this.inputType,
  });
}
