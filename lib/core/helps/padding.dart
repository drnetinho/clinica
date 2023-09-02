import 'package:flutter/material.dart';

class Padd {
  static EdgeInsets sv(double value) => EdgeInsets.symmetric(vertical: value);
  static EdgeInsets sh(double value) => EdgeInsets.symmetric(horizontal: value);

  static EdgeInsets s({required double v, required double h}) {
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  static EdgeInsets only({double? r, double? l, double? t, double? b}) {
    return EdgeInsets.only(
      right: r ?? 0.0,
      left: l ?? 0.0,
      top: t ?? 0.0,
      bottom: b ?? 0.0,
    );
  }
}
