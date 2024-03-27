import 'package:flutter/material.dart';
import 'custom_container.dart';

class TimetableEntryContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final TimeOfDay time;
  final dynamic reference;

  const TimetableEntryContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.reference,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title.toUpperCase(),
                      softWrap: true,
                      style: const TextStyle(
                        height: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      softWrap: true,
                      style: const TextStyle(height: 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time.format(context),
                    softWrap: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (reference != null)
                    Text(
                      reference.toString(),
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
