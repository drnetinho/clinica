import 'package:flutter/material.dart';

import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class AvaliationLabel extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Color? color;

  const AvaliationLabel({
    Key? key,
    required this.title,
    this.fontSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textStyles.textPoppinsSemiBold.copyWith(
        fontSize: fontSize ?? 20,
        color: color ?? ColorsApp.instance.success,
      ),
    );
  }
}
