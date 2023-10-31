import 'package:flutter/material.dart';

import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class HistoricButton extends StatelessWidget {
  final VoidCallback onTap;
  const HistoricButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: ColorsApp.instance.success,
          ),
          const SizedBox(width: 6),
          Text(
            'Visualizar histórico completo',
            style: context.textStyles.textPoppinsMedium.copyWith(
              fontSize: 14,
              color: ColorsApp.instance.success,
            ),
          ),
        ],
      ),
    );
  }
}
