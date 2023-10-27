import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'currency_formatter.dart';
import 'date_formatter.dart';

class AppFormatters {
  static MaskTextInputFormatter phoneInputFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: <String, RegExp>{
      '#': RegExp(r'[0-9]'),
    },
  );
  static MaskTextInputFormatter hourFormatter = MaskTextInputFormatter(
    mask: '##:##',
    filter: <String, RegExp>{
      '#': RegExp(r'[0-9]'),
    },
  );

  static TextInputFormatter onlyNumber = FilteringTextInputFormatter.allow(AppRegExp.onlyNumberRegEx);
  static CurrencyInputFormatter currency = CurrencyInputFormatter();
  static DateTextFormatter date = DateTextFormatter();

 static MaskTextInputFormatter cpfInputFormatter = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: <String, RegExp>{
    '#': RegExp(r'[0-9]'),
  },
);
}




class AppRegExp {
  static RegExp onlyNumberRegEx = RegExp('[0-9]');
  static RegExp chars = RegExp(r"[^\d]+");
}
