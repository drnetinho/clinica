import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class ExcluirButton extends StatelessWidget {
   final void Function()? onPressed;
  const ExcluirButton({
    super.key, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: context.colorsApp.backgroundExluirButton),
      onPressed: onPressed,
      child: Row(
        children: [
          const Icon(Icons.delete_outline, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            'Excluir',
            style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
