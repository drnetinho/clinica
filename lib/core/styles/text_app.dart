import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();
  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get fontName => 'Poppins';

  TextStyle get textPoppinsBlack => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w900);
  TextStyle get textPoppinsBlackItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic);
  TextStyle get textPoppinsBold => TextStyle(fontFamily: fontName, fontWeight: FontWeight.bold);
  TextStyle get textPoppinsBoldItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  TextStyle get textPoppinsExtraBold => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w800);
  TextStyle get textPoppinsExtraBoldItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic);
  TextStyle get textPoppinsExtraLight => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w200);
  TextStyle get textPoppinsExtraLightItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w200, fontStyle: FontStyle.italic);
  TextStyle get textPoppinsItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic);
  TextStyle get textPoppinsLight => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w300);
  TextStyle get textPoppinsLightItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic);
  TextStyle get textPoppinsMedium => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w500);
  TextStyle get textPoppinsMediumItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);
  TextStyle get textPoppinsRegular => TextStyle(fontFamily: fontName, fontWeight: FontWeight.normal);
  TextStyle get textPoppinsSemiBold => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w600);
  TextStyle get textPoppinsSemiBoldItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic);
  TextStyle get textPoppinsThin => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w100);
  TextStyle get textPoppinsThinItalic => TextStyle(fontFamily: fontName, fontWeight: FontWeight.w100, fontStyle: FontStyle.italic);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
