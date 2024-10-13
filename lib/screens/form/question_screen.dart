import 'package:flutter/material.dart';
import 'package:repeater/models/question.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/spacing.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _answerController = TextEditingController();
    _answerController.text = widget.question.answer ?? '';
  }

  @override
  void dispose() {
    widget.question.answer = _answerController.text;
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.padding1,
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.question.title,
                style: Styles.title,
                textAlign: TextAlign.center,
              ),
              Text(
                widget.question.questionText,
                textAlign: TextAlign.center,
              ),
              Spacing1(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: Styles.borderRadius1,
                        ),
                      ),
                    ),
                  ),
                  // Spacing2(),
                  // DropdownButton(
                  //   borderRadius: Styles.borderRadius1,
                  //   value: 'm',
                  //   items: [
                  //     DropdownMenuItem(
                  //       value: 'm',
                  //       child: Text('minutes'),
                  //     ),
                  //     DropdownMenuItem(
                  //       value: 'h',
                  //       child: Text('hours'),
                  //     ),
                  //   ],
                  //   onChanged: (value) {},
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
