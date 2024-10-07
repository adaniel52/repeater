import 'package:flutter/material.dart';

const blackText = Color(0xFF000000);
const greyText = Color(0xFF757575);
const spacing1 = 20.0;
const spacing2 = 10.0;

class Styles {
  static const title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: blackText,
  );

  static const subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: greyText,
  );

  static const padding0 = EdgeInsets.all(0);
  static const padding1 = EdgeInsets.all(14);
  static const padding2 = EdgeInsets.all(8);

  static const borderRadius1 = BorderRadius.all(
    Radius.circular(12),
  );
  static const borderRadius2 = BorderRadius.all(
    Radius.circular(8),
  );
}
