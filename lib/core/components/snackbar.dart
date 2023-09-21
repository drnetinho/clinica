import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';

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

  void showSuccess({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: ColorsApp.instance.success,
    ));
  }
}
