import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color(0xFF77A755);
  Color get success => const Color(0xFF77A755);
  Color get secondaryColorRed => const Color(0xFFBE0202);
  Color get blackColor => const Color(0xFF000000);
  Color get whiteColor => const Color(0xFFFFFFFF);
  Color get dartWhite => const Color(0xFFF0F1F0);
  Color get dartMedium => const Color(0xFFF8F8F8);
  Color get greyColor => const Color(0xFFB4B4B4);
  Color get greyColor2 => const Color(0xFF616161);
  Color get transparentColor => const Color(0x00000000);
  Color get textCardColor => const Color(0xFF616161);
  Color get bottonBarColor => const Color(0xFFDDDBDB);
  Color get backgroundCardColor => const Color(0xFFF8F8F8);
  Color get danger => const Color(0xFFFF1313);
  Color get warning => const Color(0xFFF59E0B);
  Color get yellowColor => const Color(0xFFFFC75E);
  Color get greenColor => const Color(0xFF9FE2C2);
  Color get greenColor2 => const Color(0xFF527736);
  Color get greenDark => const Color(0xFF1A4014);
  Color get greenDark2 => const Color(0xFF77A755);
  Color get softBlack => const Color(0xFF1E211D);

  get greenGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF527736),
          Color(0xFF77A755),
          Color(0xFF527736),
        ],
      );
}

extension ColorsAppExtension on BuildContext {
  ColorsApp get colorsApp => ColorsApp.instance;
}
