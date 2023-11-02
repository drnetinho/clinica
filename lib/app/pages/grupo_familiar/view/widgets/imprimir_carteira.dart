import 'package:clisp/core/styles/text_app.dart';
import 'package:flutter/material.dart';
import '../../../../../core/styles/colors_app.dart';

class ImprimirCarteirinhaWidget extends StatelessWidget {
  const ImprimirCarteirinhaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            Icons.card_membership,
            size: 20,
            color: ColorsApp.instance.success,
          ),
          const SizedBox(width: 6),
          Text(
            'Imprimir Carteirinha',
            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: ColorsApp.instance.success),
          ),
        ],
      ),
    );
  }
}
