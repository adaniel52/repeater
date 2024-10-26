import 'package:flutter/material.dart';
import 'package:repeater/models/juz.dart';

List<Juz> filterJuzs(
  List<Juz> juzs, {
  bool isFullyMemorized = false,
  bool isPartiallyMemorized = false,
}) {
  return juzs.where((juz) {
    if (isFullyMemorized) {
      return juz.isFullyMemorized;
    } else if (isPartiallyMemorized) {
      return juz.isPartiallyMemorized;
    }
    debugPrint(juz.toString());
    return true;
  }).toList();
}
