import 'package:flutter/material.dart';

class SaveAvaliationButton extends StatelessWidget {

  final VoidCallback onPressed;
  const SaveAvaliationButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: onPressed,
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
