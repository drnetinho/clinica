import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class RouterController {}

String subRoute(String primary, String child) {
  return '$primary/$child';
}

Widget transitionSlider(BuildContext context, Animation<double> animation, Animation<double> _, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}
