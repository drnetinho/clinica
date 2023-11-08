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
  final VoidCallback? onCreate;

  const PaymentTile({
    Key? key,
    required this.paymnet,
    this.onConfirmPayment,
    this.onRevertPayment,
    this.onDeletePayment,
    this.onCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(paymnet.monthlyFee.toReal)),
        Expanded(flex: 2, child: Text(paymnet.payDate.formatted)),
        Expanded(
          flex: 2,
          child: Text(
            paymnet.pending ? 'Pendente' : 'Pago',
            style: TextStyle(
              color: paymnet.pending ? context.colorsApp.danger : context.colorsApp.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            paymnet.receiveDate?.formatted ?? 'Aguardando',
            style: TextStyle(
              color: paymnet.pending ? context.colorsApp.warning : context.colorsApp.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: PopupMenuButton<int>(
            icon: Icon(Icons.more_vert_outlined, color: context.colorsApp.blackColor),
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
                if (paymnet.pending) ...{
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
                const PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      Text(
                        'Criar',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
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
              if (value == 3) {
                onCreate?.call();
              }
            },
          ),
        ),
      ],
    );
  }
}
