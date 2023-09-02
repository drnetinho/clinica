import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class EditarButton extends StatelessWidget {
  final void Function()? onPressed;
  const EditarButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorsApp.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), side: BorderSide(color: context.colorsApp.success)),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(Icons.edit, color: context.colorsApp.success),
          const SizedBox(width: 10),
          Text(
            'Editar',
            style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 12, color: context.colorsApp.success),
          ),
        ],
      ),
    );
  }
}
