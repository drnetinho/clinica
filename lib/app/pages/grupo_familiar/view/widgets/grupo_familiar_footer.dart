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
  final VoidCallback? onConfirmRevert;
  final VoidCallback? onConfirmDelete;

  const GrupoFamiliarFooter({
    Key? key,
    required this.group,
    required this.lastPayment,
    this.onConfirmReceive,
    this.onConfirmRevert,
    this.onConfirmDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              'Status da parcela',
              style: context.textStyles.textPoppinsMedium.copyWith(
                fontSize: 16,
                color: ColorsApp.instance.greyColor2,
              ),
            ),
            Row(
              children: [
                Icon(Icons.circle,
                    color: lastPayment.pending ? context.colorsApp.warning : context.colorsApp.greenColor, size: 14),
                const SizedBox(width: 6),
                Text(
                  lastPayment.pending ? 'Pendente' : 'Pago',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        if (lastPayment.receiveDate != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recebimento',
                style:
                    context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2),
              ),
              Text(
                lastPayment.receiveDate!.formatted,
                style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
              ),
            ],
          ),
        PopupMenuButton<int>(
          icon: Icon(Icons.more_vert_outlined, color: context.colorsApp.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: context.colorsApp.danger,
                    ),
                    Text(
                      'Deletar',
                      style: TextStyle(
                        color: context.colorsApp.danger,
                      ),
                    ),
                  ],
                ),
              ),
              if (lastPayment.pending) ...{
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: context.colorsApp.success,
                      ),
                      Text(
                        'Confirmar',
                        style: TextStyle(
                          color: context.colorsApp.success,
                        ),
                      ),
                    ],
                  ),
                )
              } else ...{
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.refresh,
                        color: context.colorsApp.warning,
                      ),
                      Text(
                        'Reverter',
                        style: TextStyle(
                          color: context.colorsApp.warning,
                        ),
                      ),
                    ],
                  ),
                )
              },
            ];
          },
          onSelected: (value) {
            if (value == 0) {
              onConfirmDelete?.call();
            }
            if (value == 1) {
              onConfirmReceive?.call();
            }
            if (value == 2) {
              onConfirmRevert?.call();
            }
          },
        ),
      ],
    );
  }
}
