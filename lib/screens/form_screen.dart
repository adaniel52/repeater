import 'package:flutter/material.dart';
import 'package:repeater/models/question.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_button.dart';
import 'package:repeater/widgets/spacing.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  final List<Question> _questions = [
    Question(
      title: 'Daily Review Time',
      questionText:
          'How much time can you spend reviewing your memorisation daily?',
      inputType: '',
    ),
    Question(
      title: 'Preferred Reminder Interval',
      questionText:
          'How often would you like to be reminded to review a memorised page?',
      inputType: '',
    ),
    //   'How many pages would you like to be reminded to review a memorised page?',
  ];

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
        itemCount: totalQuestions,
        itemBuilder: (context, index) {
          final question = _questions[index];
          return Padding(
            padding: Styles.padding1,
            child: Center(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      question.title,
                      style: Styles.title,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      question.questionText,
                      textAlign: TextAlign.center,
                    ),
                    Spacing1(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: Styles.borderRadius1,
                              ),
                            ),
                          ),
                        ),
                        Spacing2(),
                        DropdownButton(
                          borderRadius: Styles.borderRadius1,
                          value: 'm',
                          items: [
                            DropdownMenuItem(
                              value: 'm',
                              child: Text('minutes'),
                            ),
                            DropdownMenuItem(
                              value: 'h',
                              child: Text('hours'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (currentQuestion != 1)
                ? IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  )
                : SizedBox(),
            (currentQuestion != totalQuestions)
                ? IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  )
                : SizedBox(
                    width: 100,
                    child: CustomButton(labelText: 'Submit'),
                  )
          ],
        ),
      ),
    );
  }
}
