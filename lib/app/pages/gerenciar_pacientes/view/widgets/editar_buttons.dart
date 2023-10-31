import 'package:flutter/material.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

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
        backgroundColor: isEditing ? context.colorsApp.success : context.colorsApp.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: context.colorsApp.success,
          ),
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? Center(
              child: SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  color: context.colorsApp.whiteColor,
                  strokeWidth: 2.0,
                ),
              ),
            )
          : Row(
              children: [
                Icon(isEditing ? Icons.check : Icons.edit,
                    color: isEditing ? context.colorsApp.whiteColor : context.colorsApp.success, size: 16),
                const SizedBox(width: 6),
                Text(
                  isEditing ? 'Salvar' : 'Editar',
                  style: context.textStyles.textPoppinsSemiBold.copyWith(
                    fontSize: 12,
                    color: isEditing ? context.colorsApp.whiteColor : context.colorsApp.success,
                  ),
                ),
              ],
            ),
    );
  }
}
