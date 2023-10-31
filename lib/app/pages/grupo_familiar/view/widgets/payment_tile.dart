import 'package:flutter/material.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/helps/extension/money_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';

class PaymentTile extends StatelessWidget {
  final FamilyPaymnetModel paymnet;
  final VoidCallback? onConfirmPayment;
  final VoidCallback? onRevertPayment;
  final VoidCallback? onDeletePayment;

  const PaymentTile({
    Key? key,
    required this.paymnet,
    this.onConfirmPayment,
    this.onRevertPayment,
    this.onDeletePayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(paymnet.monthlyFee.toReal)),
        Expanded(flex: 2, child: Text(paymnet.payDate.formatted)),
        Expanded(flex: 2, child: Text(paymnet.pending ? 'Pendente' : 'Pago')),
        Expanded(flex: 2, child: Text(paymnet.receiveDate?.formatted ?? 'Pendente')),
        Expanded(
          flex: 1,
          child: PopupMenuButton<int>(
            icon: Icon(Icons.more_vert_outlined, color: context.colorsApp.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Deletar'),
                ),
                if (paymnet.pending) ...{
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Confirmar'),
                  )
                } else ...{
                  const PopupMenuItem(
                    value: 2,
                    child: Text('Reverter'),
                  )
                },
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                onDeletePayment?.call();
              }
              if (value == 1) {
                onConfirmPayment?.call();
              }
              if (value == 2) {
                onRevertPayment?.call();
              }
            },
          ),
        ),
      ],
    );
  }
}
