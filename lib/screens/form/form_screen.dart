import 'package:flutter/material.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_button.dart';
import 'package:repeater/widgets/main_navigation.dart';
import 'package:repeater/widgets/spacing.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _juzController;

  bool hasKhatam = false;

  @override
  void initState() {
    super.initState();
    _juzController = TextEditingController();
  }

  @override
  void dispose() {
    _juzController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form',
          style: Styles.title,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: Styles.padding1,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _khatamForm(),
                    Spacing2(),
                    TextFormField(
                      controller: _juzController,
                      decoration: InputDecoration(
                        labelText: 'Juz',
                        hintText: '1 - 30',
                        border: OutlineInputBorder(
                            borderRadius: Styles.borderRadius1),
                      ),
                      onChanged: (_) {
                        _formKey.currentState!.validate();
                      },
                      validator: (value) {
                        int? juz = int.tryParse(value!);
                        if (juz == null || juz < 1 || juz > 30) {
                          return 'Invalid input.';
                        }
                        return null;
                      },
                    ),
                    Spacing1(),
                    CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await UserPreferences.setUser(
                            User(
                              juz: int.tryParse(_juzController.text) ?? 0,
                            ),
                          );
                          if (!context.mounted) return;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const MainNavigation(),
                            ),
                            (_) => false,
                          );
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _khatamForm() => ListTile(
        contentPadding: Styles.padding0,
        title: Text('Have you khatam?'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChoiceChip(
              label: Text('Yes'),
              selected: hasKhatam,
              onSelected: (_) {
                setState(() {
                  hasKhatam = true;
                });
              },
            ),
            Spacing2(),
            ChoiceChip(
              label: Text('No'),
              selected: !hasKhatam,
              onSelected: (_) {
                setState(() {
                  hasKhatam = false;
                });
              },
            ),
          ],
        ),
      );
}

// class FormScreen extends StatefulWidget {
//   const FormScreen({super.key});

//   @override
//   State<FormScreen> createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> {
//   late PageController _pageController;
//   int _currentIndex = 0;

//   String var1 = '';

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   final List<Question> _questions = [
//     Question(
//       title: 'Which juz have you memorized?',
//       questionText:
//           'How much time can you spend reviewing your memorisation daily?',
//     ),
//     Question(
//       title: 'Preferred Reminder Interval',
//       questionText:
//           'How often would you like to be reminded to review a memorised page?',
//     ),
//     Question(title: '', questionText: ''),
//     Question(title: '', questionText: ''),
//     Question(title: '', questionText: ''),
//     //   'How many pages would you like to be reminded to review a memorised page?',
//   ];

//   void _handleSubmit() {}

//   @override
//   Widget build(BuildContext context) {
//     final currentQuestion = _currentIndex + 1;
//     final totalQuestions = _questions.length;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Question $currentQuestion of $totalQuestions'),
//         bottom: PreferredSize(
//           preferredSize: Size.zero,
//           child: LinearProgressIndicator(
//             value: _currentIndex / totalQuestions,
//           ),
//         ),
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         physics: NeverScrollableScrollPhysics(),
//         // itemCount: totalQuestions,
//         itemBuilder: (context, index) {
//           // final question = _questions[index];
//           // return QuestionScreen(question: question);
//           return CheckboxForm();
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             (currentQuestion != 1)
//                 ? CustomButton(
//                     width: 130,
//                     onPressed: () {
//                       _pageController.previousPage(
//                         duration: Duration(milliseconds: 300),
//                         curve: Curves.ease,
//                       );
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Icon(
//                           Icons.adaptive.arrow_back,
//                           size: 16,
//                         ),
//                         Text(
//                           'Previous',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   )
//                 : SizedBox(),
//             (currentQuestion != totalQuestions)
//                 ? CustomButton(
//                     width: 130,
//                     onPressed: () {
//                       _pageController.nextPage(
//                         duration: Duration(milliseconds: 300),
//                         curve: Curves.ease,
//                       );
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Next',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Icon(
//                           Icons.adaptive.arrow_forward,
//                           size: 16,
//                         ),
//                       ],
//                     ),
//                   )
//                 : CustomButton(
//                     width: 130,
//                     onPressed: _handleSubmit,
//                     child: Text('Submit'),
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }

class JuzProgressForm extends StatefulWidget {
  const JuzProgressForm({super.key});

  @override
  State<JuzProgressForm> createState() => _JuzProgressFormState();
}

class _JuzProgressFormState extends State<JuzProgressForm> {
  Map<String, String> progress = {
    '1': 'None',
    '2': 'None',
    '3': 'None',
    '4': 'None',
  };
  List<String> options = ['None', 'Partially', 'Fully'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: progress.keys
          .map(
            (juz) => ListTile(
              title: Text('Juz $juz'),
              trailing: SizedBox(
                width: 250,
                child: Row(
                  children: options
                      .map(
                        (option) => Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: ChoiceChip(
                            label: Text(option),
                            selected: progress[juz] == option,
                            onSelected: (value) {
                              setState(() {
                                progress[juz] = option;
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
