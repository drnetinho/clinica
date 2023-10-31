import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clisp/core/helps/spacing.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

class AppFormField extends StatelessWidget {
  final int? maxLength;
  final bool? readOnly;
  final double? fontSize;
  final String? hint;
  final String? labelText;
  final Color? hintColor;
  final double? hintSize;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool? enabled;
  final bool underline;
  final bool? useMask;
  final bool? autofocus;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? borderColor;
  final Color? enableBorderColor;
  final Color? disabledBorderColor;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final FocusNode? focusNode;
  final bool hideLabel;
  final int? minLines;
  final int? maxLines;
  final InputDecoration? decoration;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final TextStyle? suffixStyle;
  final BoxConstraints? suffixIconConstraints;
  final String? suffixText;
  final String? errorText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final TextStyle? prefixStyle;
  final BoxConstraints? prefixIconConstraints;
  final String? prefixText;
  final Widget? prefix;
  final EdgeInsetsGeometry? contentPadding;
  final String? helperText;
  final String? initialValue;
  final bool? filled;
  final Color? filledColor;
  final bool isValid;
  final bool isDense;
  final void Function(String)? onSubmit;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? textStyle;
  final double? minHeight;
  final double maxHeight;
  final double maxWidth;
  final bool? expands;
  final List<TextInputFormatter>? inputFormatters;

  static const double height = 90;
  static const double width = 200;

  const AppFormField({
    super.key,
    this.minHeight,
    this.maxHeight = height,
    this.maxWidth = width,
    this.textStyle,
    this.autovalidateMode,
    this.filled,
    this.onSubmit,
    this.filledColor,
    this.onTap,
    this.underline = false,
    this.helperText,
    this.initialValue,
    this.errorText,
    this.contentPadding,
    this.suffixIcon,
    this.suffixStyle,
    this.suffixText,
    this.suffixIconConstraints,
    this.suffixIconColor,
    this.suffix,
    this.prefixIcon,
    this.prefixStyle,
    this.prefixText,
    this.prefixIconConstraints,
    this.prefixIconColor,
    this.isValid = false,
    this.prefix,
    this.decoration,
    this.maxLength,
    this.errorBorderColor,
    this.readOnly = false,
    this.isDense = true,
    this.fontSize,
    this.hint = '',
    this.labelText,
    this.hintColor,
    this.hintSize,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.useMask = false,
    this.autofocus = false,
    this.padding,
    this.margin,
    this.focusedBorderColor,
    this.validator,
    this.onSaved,
    this.focusNode,
    this.borderColor,
    this.enableBorderColor,
    this.disabledBorderColor,
    this.hideLabel = true,
    this.minLines,
    this.maxLines,
    this.expands,
    this.inputFormatters,
  });

  double get getMaxHeight => labelText != null ? maxHeight + 30 : height;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: getMaxHeight,
        maxWidth: maxWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null) ...{
            Text(
              labelText ?? '',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
            ),
            Spacing.s.verticalGap,
          },
          TextFormField(
            inputFormatters: inputFormatters,
            onTap: onTap,
            onChanged: onChanged,
            onSaved: onSaved,
            onFieldSubmitted: onSubmit,
            autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
            enabled: enabled,
            maxLength: maxLength,
            readOnly: readOnly!,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: keyboardType,
            cursorWidth: 1,
            cursorColor: ColorsApp.instance.blackColor,
            autofocus: autofocus!,
            controller: controller,
            focusNode: focusNode,
            obscureText: isPassword,
            validator: validator,
            minLines: minLines,
            maxLines: maxLines,
            style: textStyle ?? context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
            expands: expands ?? false,
            initialValue: initialValue,
            decoration: decoration ??
                InputDecoration(
                  helperText: null,
                  errorText: null,
                  errorMaxLines: 1,
                  errorStyle: const TextStyle(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  isDense: isDense,
                  suffixIcon: suffixIcon,
                  suffixIconColor: suffixIconColor,
                  suffixStyle: suffixStyle,
                  suffixIconConstraints: suffixIconConstraints,
                  suffixText: suffixText,
                  suffix: suffix,
                  prefixIcon: prefixIcon,
                  prefixIconColor: prefixIconColor,
                  prefixStyle: prefixStyle,
                  prefixIconConstraints: prefixIconConstraints,
                  prefixText: prefixText,
                  prefix: prefix,
                  filled: filled,
                  fillColor: filledColor,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: hideLabel ? null : labelText,
                  hintText: hint,
                  hintStyle: context.textStyles.textPoppinsMedium.copyWith(
                    color: hintColor ?? ColorsApp.instance.greyColor2,
                  ),
                  contentPadding: contentPadding,
                  border: underline
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            width: 3.0,
                            color: isValid ? ColorsApp.instance.success : borderColor ?? ColorsApp.instance.greyColor2,
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            color: isValid ? ColorsApp.instance.success : borderColor ?? ColorsApp.instance.greyColor2,
                          ),
                        ),
                  enabledBorder: underline
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            width: 3.0,
                            color: isValid
                                ? ColorsApp.instance.success
                                : enableBorderColor ?? ColorsApp.instance.greyColor2,
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            color: isValid
                                ? ColorsApp.instance.success
                                : enableBorderColor ?? ColorsApp.instance.greyColor2,
                          ),
                        ),
                  disabledBorder: underline
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            width: 3.0,
                            color: isValid
                                ? ColorsApp.instance.success
                                : disabledBorderColor ?? ColorsApp.instance.greyColor2,
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            color: isValid
                                ? ColorsApp.instance.success
                                : disabledBorderColor ?? ColorsApp.instance.greyColor2,
                          ),
                        ),
                  focusedBorder: underline
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            width: 3.0,
                            color:
                                isValid ? ColorsApp.instance.success : focusedBorderColor ?? ColorsApp.instance.warning,
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            color:
                                isValid ? ColorsApp.instance.success : focusedBorderColor ?? ColorsApp.instance.warning,
                          ),
                        ),
                  errorBorder: underline
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            width: 3.0,
                            color: isValid ? ColorsApp.instance.success : errorBorderColor ?? ColorsApp.instance.danger,
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Spacing.m),
                          borderSide: BorderSide(
                            color: isValid ? ColorsApp.instance.success : errorBorderColor ?? ColorsApp.instance.danger,
                          ),
                        ),
                ),
          ),
          if (helperText != null && errorText == null) ...{
            Spacing.ss.verticalGap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 14,
                  color: ColorsApp.instance.greyColor2,
                ),
                Spacing.ss.horizotalGap,
                Text(
                  helperText ?? '',
                  style: context.textStyles.textPoppinsMedium.copyWith(
                    fontSize: 11,
                    height: 1.7,
                    color: ColorsApp.instance.greyColor2,
                  ),
                ),
              ],
            ),
          } else if (errorText != null) ...{
            Spacing.ss.verticalGap,
            Text(
              errorText!,
              style: context.textStyles.textPoppinsMedium.copyWith(
                fontSize: 11,
                color: ColorsApp.instance.danger,
              ),
            ),
          },
        ],
      ),
    );
  }
}
