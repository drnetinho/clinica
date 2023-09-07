import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class HistoricButton extends StatelessWidget {
  const HistoricButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
