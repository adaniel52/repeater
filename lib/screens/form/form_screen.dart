import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/centered_scrollable_column.dart';
import 'package:repeater/widgets/gap.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late PageController _pageController;
  int index = 0;
  bool hasKhatam = false;
  final _memorizationInfoFormKey = GlobalKey<FormState>();
  late TextEditingController _juzController;
  late TextEditingController _rubuController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _juzController = TextEditingController();
    _rubuController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _juzController.dispose();
    _rubuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      _khatamForm(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        itemCount: screens.length,
        itemBuilder: (context, index) {
          final currentScreen = screens[index];
          return CenteredScrollableColumn(
            children: [
              ...currentScreen,
              const LargeGap(),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: (index == 0)
                          ? null
                          : () {
                              _pageController.previousPage(
                                duration: Durations.medium1,
                                curve: Curves.ease,
                              );
                            },
                      label: const Text('Previous'),
                      icon: Icon(Icons.adaptive.arrow_back),
                    ),
                  ),
                  const SmallGap(),
                  Expanded(
                    child: (index + 1 == screens.length)
                        ? FilledButton(
                            onPressed: () {},
                            child: const Text('Submit'),
                          )
                        : FilledButton.icon(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Durations.medium1,
                                curve: Curves.ease,
                              );
                            },
                            label: const Text('Next'),
                            icon: Icon(Icons.adaptive.arrow_forward),
                            iconAlignment: IconAlignment.end,
                          ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _khatamForm() => [
        Text(
          'Khatam',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Text('Have you finished memorizing the Quran?'),
        const MediumGap(),
        SwitchListTile(
          contentPadding: Styles.noPadding,
          title: const Text('Khatam'),
          value: hasKhatam,
          onChanged: (value) {
            setState(() {
              hasKhatam = value;
            });
          },
        ),
        const LargeGap(),
        // Text(
        //   'Memorization Info',
        //   style: Theme.of(context).textTheme.headlineMedium,
        // ),
        const Text('Fill in the latest info.'),
        const MediumGap(),
        Form(
          key: _memorizationInfoFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _juzController,
                decoration: const InputDecoration(
                  labelText: 'Juz*',
                  helperText: 'Choose a number between 1 - 30',
                  border: OutlineInputBorder(
                    borderRadius: Styles.mediumBorderRadius,
                  ),
                ),
                validator: (value) {
                  final juz = int.tryParse(value!);
                  if (juz == null || juz < 1 || juz > 30) {
                    return 'Invalid input';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
      ];
}
