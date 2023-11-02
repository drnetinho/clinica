import 'package:clisp/core/styles/colors_app.dart';
import 'package:flutter/material.dart';

class SaveAvaliationButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool? isValid;
  const SaveAvaliationButton({
    Key? key,
    required this.onPressed,
    this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 100,
        height: 30,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isValid ?? true ? context.colorsApp.primary : context.colorsApp.greyColor,
          ),
          child: const Row(
            children: [
              Icon(Icons.check),
              Text("Salvar"),
            ],
          ),
        ),
      ),
    );
  }
}
