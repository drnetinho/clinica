import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/helps/spacing.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class AppFormField extends StatefulWidget {
  final double? width;
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
  final void Function(String)? onSubmit;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? textStyle;
  final double? minHeight;
  final double? maxHeight;
  final bool? expands;
  final List<TextInputFormatter>? inputFormatters;

  const AppFormField({
    Key? key,
    this.minHeight,
    this.maxHeight,
    this.textStyle,
    this.autovalidateMode,
    this.filled,
    this.onSubmit,
    this.filledColor,
    this.onTap,
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
    this.width = double.infinity,
    this.maxLength,
    this.errorBorderColor,
    this.readOnly = false,
    this.fontSize,
    this.hint = '',
    this.labelText = '',
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
  }) : super(key: key);

  @override
  _AppFormFieldState createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...{
          Text(
            widget.labelText ?? '',
            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
          ),
          Spacing.l.verticalGap,
        },
        TextFormField(
          inputFormatters: widget.inputFormatters,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onSubmit,
          autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.always,
          enabled: widget.enabled,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly!,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: widget.keyboardType,
          cursorWidth: 1,
          cursorColor: ColorsApp.instance.blackColor,
          autofocus: widget.autofocus!,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.isPassword,
          validator: widget.validator,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? 1,
          style: widget.textStyle ?? context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
          expands: widget.expands ?? false,
          initialValue: widget.initialValue,
          decoration: widget.decoration ??
              InputDecoration(
                helperText: null,
                errorText: null,
                errorMaxLines: 1,
                errorStyle: const TextStyle(
                  height: 0,
                  color: Colors.transparent,
                ),
                suffixIcon: widget.suffixIcon,
                suffixIconColor: widget.suffixIconColor,
                suffixStyle: widget.suffixStyle,
                suffixIconConstraints: widget.suffixIconConstraints,
                suffixText: widget.suffixText,
                suffix: widget.suffix,
                prefixIcon: widget.prefixIcon,
                prefixIconColor: widget.prefixIconColor,
                prefixStyle: widget.prefixStyle,
                prefixIconConstraints: widget.prefixIconConstraints,
                prefixText: widget.prefixText,
                prefix: widget.prefix,
                filled: widget.filled,
                fillColor: widget.filledColor,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: widget.hideLabel ? null : widget.labelText,
                hintText: widget.hint,
                hintStyle: context.textStyles.textPoppinsMedium.copyWith(
                  color: widget.hintColor ?? ColorsApp.instance.greyColor2,
                ),
                contentPadding: widget.contentPadding,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.m),
                  borderSide: BorderSide(
                    color: widget.isValid
                        ? ColorsApp.instance.success
                        : widget.borderColor ?? ColorsApp.instance.greyColor2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.m),
                  borderSide: BorderSide(
                    color: widget.isValid
                        ? ColorsApp.instance.success
                        : widget.enableBorderColor ?? ColorsApp.instance.greyColor2,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.m),
                  borderSide: BorderSide(
                    color: widget.isValid
                        ? ColorsApp.instance.success
                        : widget.disabledBorderColor ?? ColorsApp.instance.greyColor2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.m),
                  borderSide: BorderSide(
                    color: widget.isValid
                        ? ColorsApp.instance.success
                        : widget.focusedBorderColor ?? ColorsApp.instance.blackColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.m),
                  borderSide: BorderSide(
                    color: widget.isValid
                        ? ColorsApp.instance.success
                        : widget.errorBorderColor ?? ColorsApp.instance.danger,
                  ),
                ),
              ),
        ),
        if (widget.helperText != null) ...{
          Spacing.l.verticalGap,
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 18,
                color: ColorsApp.instance.greyColor2,
              ),
              Spacing.l.horizotalGap,
              Text(
                widget.helperText ?? '',
                style: context.textStyles.textPoppinsMedium.copyWith(
                  fontSize: 14,
                  height: 1.7,
                  color: ColorsApp.instance.greyColor2,
                ),
              ),
            ],
          ),
        },
        if (widget.errorText != null && widget.controller?.text.isMoreThanOne == true) ...{
          Spacing.l.horizotalGap,
          Text(
            widget.errorText ?? '',
            style: context.textStyles.textPoppinsMedium.copyWith(
              fontSize: 14,
              color: ColorsApp.instance.danger,
            ),
          ),
        }
      ],
    );
  }
}
