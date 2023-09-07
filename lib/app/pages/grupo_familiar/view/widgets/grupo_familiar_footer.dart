import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class GrupoFamiliarFooter extends StatelessWidget {
  final FamilyGroupModel group;
  const GrupoFamiliarFooter({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Valor',
                style:
                    context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2)),
            Text('R\$ 50,00', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vencimento',
                style:
                    context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2)),
            Text('10/10/2021', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status',
                style:
                    context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2)),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
