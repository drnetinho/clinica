import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppFormatters {
  static MaskTextInputFormatter phoneInputFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: <String, RegExp>{
      '#': RegExp(r'[0-9]'),
    },
  );

  static TextInputFormatter onlyNumber = FilteringTextInputFormatter.allow(RegExp('[0-9]'));
}
