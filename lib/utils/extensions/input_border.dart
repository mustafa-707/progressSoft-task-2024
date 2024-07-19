import 'package:flutter/material.dart';
import 'package:progressofttask/utils/constants.dart';

extension OutlineInputBorderExtension on OutlineInputBorder {
  static OutlineInputBorder border({
    required Color color,
    double width = 1.0,
    double radius = pButtonRadius,
  }) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: width,
        color: color,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );
  }
}
