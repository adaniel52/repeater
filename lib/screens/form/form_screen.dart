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
  List<String> options = ['None', 'Partially', 'Fully'];
  late final TextEditingController _juzController;
  late final TextEditingController _rubuController;

  bool hasKhatam = false;
  Map<String, String> reviewProgress = {};

  @override
  void initState() {
    super.initState();
    _juzController = TextEditingController();
    _rubuController = TextEditingController();
    _initProgress();
  }

  @override
  void dispose() {
    _juzController.dispose();
    _rubuController.dispose();
    super.dispose();
  }

  void _initProgress() {
    for (var i = 1; i <= 30; i++) {
      reviewProgress[i.toString()] = 'None';
    }
  }

  @override
  Widget build(BuildContext context) {
    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        await UserPreferences.setUser(
          User(
            juz: int.tryParse(_juzController.text) ?? 0,
            rubu: int.tryParse(_rubuController.text) ?? 0,
            reviewProgress: reviewProgress,
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
    }

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
                padding: Styles.padding1,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _khatamForm(),
                      Divider(),
                      if (!hasKhatam) ...[
                        Spacing2(),
                        Text('Fill in your current memorization info.'),
                        Spacing1(),
                        _juzForm(),
                        Spacing2(),
                        _rubuForm(),
                        Spacing1(),
                        Divider(),
                      ],
                      _reviewProgressForm(),
                      Spacing2(),
                      Divider(),
                      Spacing1(),
                      _submitButton(handleSubmit),
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
        contentPadding: Styles.padding0,
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

  Widget _juzForm() => TextFormField(
        controller: _juzController,
        decoration: InputDecoration(
          labelText: 'Juz*',
          hintText: '1 - 30',
          border: OutlineInputBorder(borderRadius: Styles.borderRadius1),
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
      );

  Widget _rubuForm() => TextFormField(
        controller: _rubuController,
        decoration: InputDecoration(
          labelText: 'Rubu*',
          hintText: '1 - 8',
          border: OutlineInputBorder(borderRadius: Styles.borderRadius1),
        ),
        onChanged: (_) {
          _formKey.currentState!.validate();
        },
        validator: (value) {
          int? juz = int.tryParse(value!);
          if (juz == null || juz < 1 || juz > 8) {
            return 'Invalid input.';
          }
          return null;
        },
      );

  Widget _reviewProgressForm() => Column(
        children: [
          Spacing2(),
          Text('Which juz have you still remembered?'),
          Spacing2(),
          ...reviewProgress.keys.map(
            (juz) => ListTile(
              contentPadding: Styles.padding0,
              title: Text('Juz $juz'),
              trailing: SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: options
                      .map(
                        (option) => Padding(
                          padding: const EdgeInsets.only(left: spacing2),
                          child: ChoiceChip(
                            label: Text(option),
                            selected: reviewProgress[juz] == option,
                            onSelected: (value) {
                              setState(() {
                                reviewProgress[juz] = option;
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _submitButton(void Function() onPressed) => CustomButton(
        onPressed: onPressed,
        child: Text('Submit'),
      );
}
