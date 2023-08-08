import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double percentWidth(double percentWidth) => width * percentWidth;
  double percentHeight(double percentHeight) => height * percentHeight;
}
