import 'package:flutter/material.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/choice_chips.dart';
import 'package:repeater/widgets/custom_button.dart';
import 'package:repeater/widgets/main_navigation.dart';
import 'package:repeater/widgets/gap.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldKey = GlobalKey();
  late final TextEditingController _juzController;
  late final TextEditingController _rubuController;
  late final ScrollController _scrollController;

  bool hasKhatam = false;
  Map<String, String> reviewProgress = {};

  @override
  void initState() {
    super.initState();
    _juzController = TextEditingController();
    _rubuController = TextEditingController();
    _scrollController = ScrollController();
    _initProgress();
  }

  @override
  void dispose() {
    _juzController.dispose();
    _rubuController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initProgress() {
    for (var i = 1; i <= 30; i++) {
      reviewProgress[i.toString()] = 'None';
    }
  }

  void _scrollToTextField() {
    final context = _textFieldKey.currentContext!;
    Scrollable.ensureVisible(context, duration: Duration(milliseconds: 500));
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      await UserPreferences().createUser(
        User(
          juz: int.tryParse(_juzController.text),
          rubu: int.tryParse(_rubuController.text),
          reviewProgress: reviewProgress,
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainNavigation(),
        ),
        (_) => false,
      );
    } else {
      _scrollToTextField();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Scrollbar(
        interactive: true,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: Styles.screenPadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _khatamForm(),
                      LargeGap(),
                      Divider(),
                      if (!hasKhatam) ...[
                        LargeGap(key: _textFieldKey),
                        _memorizationInfoForm(),
                        LargeGap(),
                        Divider(),
                      ],
                      LargeGap(),
                      _reviewProgressForm(),
                      LargeGap(),
                      Divider(),
                      LargeGap(),
                      _submitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _memorizationInfoForm() => Column(
        children: [
          Text('Fill in your current memorization info.'),
          MediumGap(),
          TextFormField(
            controller: _juzController,
            decoration: InputDecoration(
              labelText: 'Juz*',
              hintText: '1 - 30',
              border: OutlineInputBorder(
                borderRadius: Styles.mediumBorderRadius,
              ),
            ),
            onChanged: (_) {
              _formKey.currentState!.validate();
            },
            validator: (value) {
              int? juz = int.tryParse(value!);
              if (juz == null || juz < 1 || juz > 30) {
                return 'Invalid input';
              } else {
                return null;
              }
            },
          ),
          MediumGap(),
          TextFormField(
            controller: _rubuController,
            decoration: InputDecoration(
              labelText: 'Rubu*',
              hintText: '1 - 8',
              border: OutlineInputBorder(
                borderRadius: Styles.mediumBorderRadius,
              ),
            ),
            onChanged: (_) {
              _formKey.currentState!.validate();
            },
            validator: (value) {
              int? rubu = int.tryParse(value!);
              if (rubu == null || rubu < 1 || rubu > 8) {
                return 'Invalid input';
              } else {
                return null;
              }
            },
          ),
        ],
      );

  Widget _khatamForm() => ListTile(
        contentPadding: Styles.noPadding,
        title: Text('Khatam'),
        trailing: ChoiceChips(
          options: ['Yes', 'No'],
          selected: hasKhatam ? 'Yes' : 'No',
          onSelected: (value) {
            setState(() {
              hasKhatam = value == 'Yes' ? true : false;
            });
          },
        ),
      );

  Widget _reviewProgressForm() => Column(
        children: [
          Text('Which rubu have you still remembered?'),
          MediumGap(),
          ...reviewProgress.keys.map((juz) {
            return ListTile(
              contentPadding: Styles.noPadding,
              title: Text('Juz $juz'),
              trailing: ChoiceChips(
                options: ['None', 'Partially', 'Fully'],
                selected: reviewProgress[juz]!,
                onSelected: (value) {
                  setState(() {
                    reviewProgress[juz] = value;
                  });
                },
              ),
            );
          }),
        ],
      );

  Widget _submitButton() => CustomButton(
        onPressed: _handleSubmit,
        child: Text('Submit'),
      );
}
