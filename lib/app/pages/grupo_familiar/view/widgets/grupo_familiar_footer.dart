import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/money_extension.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';
import '../../domain/model/family_payment_model.dart';

class GrupoFamiliarFooter extends StatelessWidget {
  final FamilyGroupModel group;
  final List<FamilyPaymnetModel> payments;
  const GrupoFamiliarFooter({
    Key? key,
    required this.group,
    required this.payments,
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
            Text(
              'Valor',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2),
            ),
            // TODO (Artur) Verificar se pego o First item ou o Last
            Text(
              payments.first.monthlyFee.toReal,
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vencimento',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2),
            ),
            Text(
              payments.first.payDate.formatted,
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status',
              style: context.textStyles.textPoppinsMedium.copyWith(
                fontSize: 16,
                color: ColorsApp.instance.greyColor2,
              ),
            ),
            Text(
              payments.any((e) => e.pending) ? 'Pendente' : 'Pago',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
