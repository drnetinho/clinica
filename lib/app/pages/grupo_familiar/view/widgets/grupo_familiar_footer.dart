import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/money_extension.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';
import '../../domain/model/family_payment_model.dart';

class GrupoFamiliarFooter extends StatelessWidget {
  final FamilyGroupModel group;
  final FamilyPaymnetModel lastPayment;
  final VoidCallback? onConfirmReceive;

  const GrupoFamiliarFooter({
    Key? key,
    required this.group,
    required this.lastPayment,
    this.onConfirmReceive,
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
              lastPayment.monthlyFee.toReal,
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
              lastPayment.payDate.formatted,
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
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: lastPayment.pending ? context.colorsApp.danger : context.colorsApp.greenColor,
                ),
                Text(
                  lastPayment.pending ? 'Pendente' : 'Pago',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        if (lastPayment.pending) ...{
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recebimento',
                style: context.textStyles.textPoppinsMedium.copyWith(
                  fontSize: 16,
                  color: ColorsApp.instance.greyColor2,
                ),
              ),
              ElevatedButton(
                onPressed: onConfirmReceive,
                child: const Text('Confirmar'),
              ),
            ],
          ),
        },
        const Spacer(),
      ],
    );
  }
}
