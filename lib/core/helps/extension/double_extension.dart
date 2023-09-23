extension DoubleToPercent on double {
  String get toPercent => '${(this * 100).toStringAsFixed(0)}%';
}