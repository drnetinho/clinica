import 'package:flutter/material.dart';

extension ValueNotifierValidator on ValueNotifier {
  bool get exists => value != null;
}
