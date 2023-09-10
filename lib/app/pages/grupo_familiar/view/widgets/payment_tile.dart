import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/money_extension.dart';

class PaymentTile extends StatelessWidget {
  final FamilyPaymnetModel paymnet;
  final VoidCallback? onConfirmPayment;
  final VoidCallback? onRevertPayment;

  const PaymentTile({
    Key? key,
    required this.paymnet,
    this.onConfirmPayment,
    this.onRevertPayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(paymnet.monthlyFee.toReal)),
        Expanded(flex: 2, child: Text(paymnet.payDate.formatted)),
        Expanded(flex: 2, child: Text(paymnet.receiveDate?.formatted ?? 'Pendente')),
        Expanded(flex: 2, child: Text(paymnet.pending ? 'Pendente' : 'Pago')),
        // TODO THIAGO Estilizar textos e este botao
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              if (paymnet.pending) {
                onConfirmPayment?.call();
              } else {
                onRevertPayment?.call();
              }
            },
            child: Text(paymnet.pending ? 'Confirmar' : 'Reverter'),
          ),
        ),
      ],
    );
  }
}
