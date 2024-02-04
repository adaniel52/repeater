import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController pageController;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String label;
  final String? hintText;
  final String? Function(String?)? validator;

  const MyTextFormField({
    super.key,
    required this.pageController,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    required this.label,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: pageController,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          label: Text(label),
          hintText: hintText,
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
