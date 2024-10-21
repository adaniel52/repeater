import 'package:flutter/material.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
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
      await UserPreferences.setUser(
        User(
          juz: int.tryParse(_juzController.text) ?? 0,
          rubu: int.tryParse(_rubuController.text) ?? 0,
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
                      Divider(),
                      if (!hasKhatam) ...[
                        LargeGap(
                          key: _textFieldKey,
                        ),
                        Text('Fill in your current memorization info.'),
                        MediumGap(),
                        _juzForm(),
                        LargeGap(),
                        _rubuForm(),
                        MediumGap(),
                        Divider(),
                      ],
                      _reviewProgressForm(),
                      LargeGap(),
                      Divider(),
                      MediumGap(),
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

  Widget _khatamForm() => ListTile(
        contentPadding: Styles.noPadding,
        title: Text('Khatam'),
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
            LargeGap(),
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

  Widget _juzForm() => TextFormField(
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
          }
          return null;
        },
      );

  Widget _rubuForm() => TextFormField(
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
          int? juz = int.tryParse(value!);
          if (juz == null || juz < 1 || juz > 8) {
            return 'Invalid input';
          }
          return null;
        },
      );

  Widget _reviewProgressForm() => Column(children: [
        LargeGap(),
        Text('Which juz have you still remembered?'),
        LargeGap(),
        ...reviewProgress.keys.map((juz) {
          return ListTile(
            contentPadding: Styles.noPadding,
            title: Text('Juz $juz'),
            trailing: SizedBox(
              width: 270,
              child: SegmentedButton(
                segments: [
                  ButtonSegment(
                    value: 'None',
                    label: FittedBox(child: Text('None')),
                  ),
                  ButtonSegment(
                    value: 'Partially',
                    label: FittedBox(child: Text('Partially')),
                  ),
                  ButtonSegment(
                    value: 'Fully',
                    label: FittedBox(child: Text('Fully')),
                  ),
                ],
                selected: {reviewProgress[juz]},
                onSelectionChanged: (value) {
                  setState(() {
                    reviewProgress[juz] = value.first!;
                  });
                },
              ),
            ),
          );
        }),
      ]);

  Widget _submitButton() => CustomButton(
        onPressed: _handleSubmit,
        child: Text('Submit'),
      );
}
