import 'package:flutter/material.dart';

class Spacing {
  static const double s = 6.0;
  static const double m = 10.0;
  static const double l = 12.0;
  static const double x = 16.0;
  static const double xs = 20.0;
  static const double xxs = 24.0;
  static const double xm = 28.0;
  static const double xxm = 32.0;
  static const double xl = 36.0;
  static const double xxl = 40.0;
}

extension Gap on double {
  Widget get verticalGap => SizedBox(height: this);
  Widget get horizotalGap => SizedBox(width: this);
}
