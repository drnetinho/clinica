import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final TextEditingController controller;
  final double fontSize;
  final double borderRadius;
  final String? Function(String?)? validator;
  TextInputType keyboardType;
  final bool digitsOnly;
  final bool maskTelefone;
  final bool maskData;
  final bool maskCpf;
  final String prefixText;
  final String label;
  final EdgeInsets padding;
  final bool passwordMode;
  final Function()? suffixIconFunction;
  final Function()? prefixIconFunction;
  final Function()? onTap;
  final Function(String)? onChanged;
  final AutovalidateMode autovalidateMode;
  final int maxLength;
  final bool formatNumber;
  final String initialValue;
  final bool formatMoney;
  final bool multiline;
  final String? helperText;
  final String? labelTextBorder;
  InputField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.fontSize = 16,
    this.borderRadius = 14,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.digitsOnly = false,
    this.maskData = false,
    this.maskCpf = false,
    this.maskTelefone = false,
    this.prefixText = '',
    this.label = '',
    this.padding = const EdgeInsets.all(0),
    this.passwordMode = false,
    this.suffixIconFunction,
    this.prefixIconFunction,
    this.onTap,
    this.maxLength = 1000,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.formatNumber = true,
    this.initialValue = '',
    this.formatMoney = false,
    this.multiline = false,
    this.helperText,
    this.labelTextBorder,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(true);

    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return ValueListenableBuilder(
      valueListenable: passwordVisible,
      builder: (context, value, child) => Padding(
        padding: widget.padding,
        child: TextFormField(
          maxLength: widget.maxLength,
          controller: widget.controller,
          obscureText: widget.passwordMode ? passwordVisible.value : false,
          textInputAction: TextInputAction.done,
          inputFormatters: [
            if (widget.maskData) DateFormatter(),
            if (widget.maskTelefone) PhoneNumberFormatter(),
            if (widget.maskCpf) CpfFormatter(),
          ],
          keyboardType: (isIOS && widget.keyboardType == TextInputType.number) || widget.maskData || widget.digitsOnly
              ? const TextInputType.numberWithOptions(signed: true, decimal: true)
              : widget.keyboardType,
          maxLines: widget.multiline ? 6 : 1,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          onChanged: (value) {
            //
          },
          onTap: widget.onTap,
          readOnly: widget.onTap != null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(width: 1, color: Color(0xFFB4B4B4)),
            ),
            label: Text(
              widget.labelTextBorder ?? '',
              style: TextStyle(
                color: const Color(0xFF000000).withOpacity(0.6),
                fontSize: widget.fontSize,
              ),
            ),
            counterText: '',
            prefixIcon: widget.prefixIcon != null
                ? InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: widget.prefixIconFunction ?? () {},
                    child: Icon(
                      widget.prefixIcon,
                      color: const Color(0xFFB4B4B4),
                    ),
                  )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: widget.passwordMode ? () => passwordVisible.value = !passwordVisible.value : widget.suffixIconFunction ?? () {},
                    child: Icon(
                      widget.passwordMode ? (passwordVisible.value ? Icons.visibility_outlined : Icons.visibility_off_outlined) : widget.suffixIcon,
                      color: const Color(0xFFB4B4B4),
                    ),
                  )
                : null,
            contentPadding: widget.prefixIcon != null
                ? EdgeInsets.symmetric(horizontal: 0, vertical: (widget.multiline) ? 15 : 0)
                : EdgeInsets.symmetric(horizontal: 15, vertical: (widget.multiline) ? 15 : 0),
            hintText: widget.label,
            prefixText: widget.prefixText,
            helperText: widget.helperText,
            helperStyle: TextStyle(
              fontSize: widget.fontSize,
              color: const Color(0xFFB4B4B4),
              fontFamily: context.textStyles.textPoppinsMedium.fontFamily,
            ),
            labelStyle: TextStyle(
              color: const Color(0xFFB4B4B4),
              fontSize: widget.fontSize,
            ),
            hintStyle: TextStyle(
              fontSize: widget.fontSize,
              color: const Color(0xFFB4B4B4),
              fontFamily: context.textStyles.textPoppinsMedium.fontFamily,
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.1 : 0.25),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
              borderSide: const BorderSide(
                color: Color(0xFFB4B4B4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
              borderSide: const BorderSide(
                color: Color(0xFFB4B4B4),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
              borderSide: const BorderSide(color: Color(0xFFF44336)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
              borderSide: const BorderSide(color: Color(0xFFF44336)),
            ),
            errorStyle: TextStyle(
              fontSize: 12,
              color: const Color.fromRGBO(244, 67, 54, 1),
              fontFamily: context.textStyles.textPoppinsMedium.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}

class DateFormatter extends TextInputFormatter {
  final String mask = 'xx/xx/xxxx';
  final String separator = '/';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        String lastEnteredChar = newValue.text.substring(newValue.text.length - 1);

        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
          String value = _validateValueData(oldValue.text);

          return TextEditingValue(
            text: '$value$separator$lastEnteredChar',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }

        if (newValue.text.length == mask.length) {
          return TextEditingValue(
            text: _validateValueData(newValue.text),
            selection: TextSelection.collapsed(
              offset: newValue.selection.end,
            ),
          );
        }
      }
    }
    return newValue;
  }

  String _validateValueData(String s) {
    String result = s;

    if (s.length < 4) {
      // days
      int num = int.parse(s.substring(s.length - 2));
      String raw = s.substring(0, s.length - 2);
      if (num == 0) {
        result = '${raw}01';
      } else if (num > 31) {
        result = '${raw}31';
      } else {
        result = s;
      }
    } else if (s.length < 7) {
      // month
      int num = int.parse(s.substring(s.length - 2));
      String raw = s.substring(0, s.length - 2);
      if (num == 0) {
        result = '${raw}01';
      } else if (num > 12) {
        result = '${raw}12';
      } else {
        result = s;
      }
    } else {
      // year
      int num = int.parse(s.substring(s.length - 4));
      String raw = s.substring(0, s.length - 4);
      if (num < 1950) {
        result = '${raw}1950';
      } else if (num > 2006) {
        result = '${raw}2006';
      } else {
        result = s;
      }
    }
    return result;
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String cleanedText = newValue.text.replaceAll(RegExp(r'\D'), '');

    String formattedText = '';
    // formato 91 9 9999-9999

    if (cleanedText.isNotEmpty) {
      if (cleanedText.length > 2) {
        formattedText = '(${cleanedText.substring(0, 2)}) ';
        if (cleanedText.length > 3) {
          formattedText += '${cleanedText.substring(2, 3)} ';
          if (cleanedText.length > 7) {
            formattedText += '${cleanedText.substring(3, 7)}-';
            formattedText += cleanedText.substring(7);
          } else {
            formattedText += cleanedText.substring(3);
          }
        } else {
          formattedText += cleanedText.substring(2);
        }
      } else {
        formattedText = cleanedText;
      }
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class CpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String cleanedText = newValue.text.replaceAll(RegExp(r'\D'), '');

    String formattedText = '';

    if (cleanedText.isNotEmpty) {
      if (cleanedText.length > 3) {
        formattedText = '${cleanedText.substring(0, 3)}.';
        if (cleanedText.length > 6) {
          formattedText += '${cleanedText.substring(3, 6)}.';
          if (cleanedText.length > 9) {
            formattedText += '${cleanedText.substring(6, 9)}-';
            formattedText += cleanedText.substring(9);
          } else {
            formattedText += cleanedText.substring(6);
          }
        } else {
          formattedText += cleanedText.substring(3);
        }
      } else {
        formattedText = cleanedText;
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
