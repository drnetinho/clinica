import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primaryColor => const Color(0xFFD50858);
  Color get secondaryColor => const Color(0xFFF5196D);
  Color get tertiaryColor => const Color(0xFFF7CEDE);
  Color get transparentColor => const Color(0x00000000);
}

extension ColorsAppExtension on BuildContext {
  ColorsApp get colorsApp => ColorsApp.instance;
}
