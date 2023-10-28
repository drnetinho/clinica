import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class ExcluirButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool discardMode;
  const ExcluirButton({
    super.key,
    this.onPressed,
    this.discardMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: discardMode ? context.colorsApp.dartWhite : context.colorsApp.danger,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: discardMode ? context.colorsApp.dartWhite : context.colorsApp.danger,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(discardMode ? Icons.close : Icons.delete_outline,
              color: discardMode ? Colors.black : Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            discardMode ? 'Cancelar' : 'Excluir',
            style: context.textStyles.textPoppinsSemiBold.copyWith(
              fontSize: 12,
              color: discardMode ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
