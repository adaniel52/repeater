import 'package:flutter/material.dart';
import 'package:repeater/models/question.dart';
import 'package:repeater/widgets/custom_button.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  String var1 = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  final List<Question> _questions = [
    Question(
      title: 'Which juz have you memorized?',
      questionText:
          'How much time can you spend reviewing your memorisation daily?',
    ),
    Question(
      title: 'Preferred Reminder Interval',
      questionText:
          'How often would you like to be reminded to review a memorised page?',
    ),
    //   'How many pages would you like to be reminded to review a memorised page?',
  ];

  void _handleSubmit() {}

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _currentIndex + 1;
    final totalQuestions = _questions.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Question $currentQuestion of $totalQuestions'),
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: LinearProgressIndicator(
            value: _currentIndex / totalQuestions,
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(),
        // itemCount: totalQuestions,
        itemBuilder: (context, index) {
          // final question = _questions[index];
          // return QuestionScreen(question: question);
          return CheckboxForm();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (currentQuestion != 1)
                ? CustomButton(
                    width: 130,
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.adaptive.arrow_back,
                          size: 16,
                        ),
                        Text(
                          'Previous',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            (currentQuestion != totalQuestions)
                ? CustomButton(
                    width: 130,
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.adaptive.arrow_forward,
                          size: 16,
                        ),
                      ],
                    ),
                  )
                : CustomButton(
                    width: 130,
                    onPressed: _handleSubmit,
                    child: Text('Submit'),
                  )
          ],
        ),
      ),
    );
  }
}

class CheckboxForm extends StatefulWidget {
  const CheckboxForm({super.key});

  @override
  State<CheckboxForm> createState() => _CheckboxFormState();
}

class _CheckboxFormState extends State<CheckboxForm> {
  Map<String, bool> options = {
    '1': false,
    '2': false,
    '3': false,
    '4': false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.keys.map((key) {
        return CheckboxListTile.adaptive(
          title: Text('Juz $key'),
          value: options[key],
          onChanged: (value) {
            setState(() {
              options[key] = value!;
            });
          },
        );
      }).toList(),
    );
  }
}
