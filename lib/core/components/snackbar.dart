import 'package:flutter/material.dart';
import 'package:clisp/core/styles/colors_app.dart';

mixin SnackBarMixin {
  void showSnack({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void showError({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: ColorsApp.instance.danger,
    ));
  }

  void showWarning({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: ColorsApp.instance.warning,
      duration: const Duration(seconds: 8),
    ));
  }

  void showSuccess({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: ColorsApp.instance.success,
    ));
  }
}
