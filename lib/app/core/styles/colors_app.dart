import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primaryColorGrean => const Color(0xFF77A755);
  Color get secondaryColorRed => const Color(0xFFBE0202);
  Color get blackColor => const Color(0xFF000000);
  Color get whiteColor => const Color(0xFFFFFFFF);
  Color get greyColor => const Color(0xFFB4B4B4);
  Color get greyColor2 => const Color(0xFF616161);
  Color get transparentColor => const Color(0x00000000);
}

extension ColorsAppExtension on BuildContext {
  ColorsApp get colorsApp => ColorsApp.instance;
}

