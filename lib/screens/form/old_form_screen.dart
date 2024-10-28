import 'package:flutter/material.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/widgets/main_navigation.dart';

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
  List<Juz> memorization = List.generate(30, (_) => Juz());

  @override
  void initState() {
    super.initState();
    _juzController = TextEditingController();
    _rubuController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _juzController.dispose();
    _rubuController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTextField() {
    final context = _textFieldKey.currentContext!;
    Scrollable.ensureVisible(context,
        duration: const Duration(milliseconds: 500));
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      await UserPreferences().createUser(
        User(
          juz: int.tryParse(_juzController.text),
          rubu: int.tryParse(_rubuController.text),
          juzs: memorization,
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const MainNavigation(),
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
        title: const Text('Form'),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: SizedBox(
              width: Styles.smallBreakpoint,
              child: Padding(
                padding: Styles.screenPadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _khatamForm(),
                      const LargeGap(),
                      const Divider(),
                      if (!hasKhatam) ...[
                        LargeGap(key: _textFieldKey),
                        ..._memorizationInfoForm(),
                        const LargeGap(),
                        const Divider(),
                      ],
                      const LargeGap(),
                      ..._memorizationForm(),
                      const LargeGap(),
                      const Divider(),
                      const LargeGap(),
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

  Widget _khatamForm() => SwitchListTile(
        contentPadding: Styles.noPadding,
        title: const Text('Khatam'),
        value: hasKhatam,
        onChanged: (value) {
          setState(() {
            hasKhatam = value;
          });
        },
      );

  List<Widget> _memorizationInfoForm() => [
        const Text('Fill in your current memorization info.'),
        const MediumGap(),
        TextFormField(
          controller: _juzController,
          decoration: const InputDecoration(
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
            final juz = int.tryParse(value!);
            if (juz == null || juz < 1 || juz > 30) {
              return 'Invalid input';
            } else {
              return null;
            }
          },
        ),
        const MediumGap(),
        TextFormField(
          controller: _rubuController,
          decoration: const InputDecoration(
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
            final rubu = int.tryParse(value!);
            if (rubu == null || rubu < 1 || rubu > 8) {
              return 'Invalid input';
            } else {
              return null;
            }
          },
        ),
      ];

  List<Widget> _memorizationForm() => [
        const Text('Which juz did you still remember?'),
        const MediumGap(),
        ...memorization.map((juz) {
          return SwitchListTile(
            contentPadding: Styles.noPadding,
            title: Text('Juz ${memorization.indexOf(juz) + 1}'),
            value: juz.isFullyMemorized,
            onChanged: (value) {
              setState(() {
                juz.isFullyMemorized = value;
              });
            },
          );
        }),
      ];

  Widget _submitButton() => SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: _handleSubmit,
          child: const Text('Submit'),
        ),
      );
}