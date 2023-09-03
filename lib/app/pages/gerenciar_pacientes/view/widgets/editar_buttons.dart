import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class EditarButton extends StatelessWidget {
  final bool isEditing;
  final bool isLoading;
  final void Function()? onPressed;

  const EditarButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorsApp.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isEditing ? context.colorsApp.warning : context.colorsApp.success,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(isEditing ? Icons.save : Icons.edit,
              color: isEditing ? context.colorsApp.warning : context.colorsApp.success),
          const SizedBox(width: 10),
          Text(
            isEditing ? 'Salvar' : 'Editar',
            style: context.textStyles.textPoppinsSemiBold.copyWith(
              fontSize: 12,
              color: isEditing ? context.colorsApp.warning : context.colorsApp.success,
            ),
          ),
        ],
      ),
    );
  }
}
