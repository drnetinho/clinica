import 'package:flutter/material.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

class NewDoctorsButtom extends StatelessWidget {
  final void Function()? onPressed;
  const NewDoctorsButtom({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorsApp.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(color: context.colorsApp.greenColor2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(Icons.add, size: 16, color: context.colorsApp.greenColor2),
            const SizedBox(width: 10),
            Text('Novo Médico',
                style: context.textStyles.textPoppinsSemiBold
                    .copyWith(fontSize: 18, color: context.colorsApp.greenColor2)),
          ],
        ),
      ),
    );
  }
}
