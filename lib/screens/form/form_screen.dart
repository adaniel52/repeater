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
      [const Text('yesh')]
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
            children: currentScreen,
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton.tonalIcon(
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
            (index + 1 == screens.length)
                ? FilledButton(
                    onPressed: () {},
                    child: const Text('Submit'),
                  )
                : FilledButton.icon(
                    onPressed: () {
                      switch (index) {
                        case 0:
                          if (hasKhatam) break;
                          if (!_memorizationInfoFormKey.currentState!
                              .validate()) return;
                      }
                      _pageController.nextPage(
                        duration: Durations.medium1,
                        curve: Curves.ease,
                      );
                    },
                    label: const Text('Next'),
                    icon: Icon(Icons.adaptive.arrow_forward),
                    iconAlignment: IconAlignment.end,
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> _khatamForm() => [
        Text(
          'General Info',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.start,
        ),
        const LargeGap(),
        SwitchListTile(
          contentPadding: Styles.noPadding,
          title: const Text('Khatam'),
          subtitle: const Text('Have you finished memorizing the Quran?'),
          value: hasKhatam,
          onChanged: (value) {
            setState(() {
              hasKhatam = value;
            });
          },
        ),
        if (!hasKhatam) ...[
          const SmallGap(),
          const ListTile(
            contentPadding: Styles.noPadding,
            title: Text('Memorization Info'),
            subtitle: Text('Fill in your current memorization info.'),
          ),
          const SmallGap(),
          Form(
            key: _memorizationInfoFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _juzController,
                  decoration: const InputDecoration(
                    labelText: 'Juz*',
                    helperText: 'Choose a number between 1 - 30.',
                    border: OutlineInputBorder(
                      borderRadius: Styles.mediumBorderRadius,
                    ),
                  ),
                  validator: (value) {
                    final juz = int.tryParse(value!);
                    if (juz == null || juz < 1 || juz > 30) {
                      return 'Invalid input! Choose a number between 1 - 30.';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (_) {
                    _memorizationInfoFormKey.currentState!.validate();
                  },
                ),
                const MediumGap(),
                TextFormField(
                  controller: _rubuController,
                  decoration: const InputDecoration(
                    labelText: 'Rubu*',
                    helperText: 'Choose a number between 1 - 8.',
                    border: OutlineInputBorder(
                      borderRadius: Styles.mediumBorderRadius,
                    ),
                  ),
                  validator: (value) {
                    final rubu = int.tryParse(value!);
                    if (rubu == null || rubu < 1 || rubu > 8) {
                      return 'Invalid input! Choose a number between 1 - 8.';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (_) {
                    _memorizationInfoFormKey.currentState!.validate();
                  },
                ),
              ],
            ),
          ),
        ],
      ];
}
