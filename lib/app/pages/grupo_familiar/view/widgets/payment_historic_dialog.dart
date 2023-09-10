import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_payment_model.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/payment_tile.dart';
import 'package:netinhoappclinica/app/pages/historico/widgets/drop_button.dart';

import '../../../../../core/helps/padding.dart';
import '../../../../../core/helps/spacing.dart';

class PaymentHistoricDialog extends StatefulWidget {
  final List<FamilyPaymnetModel> payments;

  const PaymentHistoricDialog({
    Key? key,
    required this.payments,
  }) : super(key: key);

  @override
  State<PaymentHistoricDialog> createState() => _PaymentHistoricDialogState();
}

class _PaymentHistoricDialogState extends State<PaymentHistoricDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: Padd.sh(Spacing.x),
        height: MediaQuery.of(context).size.height * .8,
        width: MediaQuery.of(context).size.width * .4,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: Padd.only(t: 150),
                  child: const Row(
                    children: [
                      Expanded(flex: 2, child: Text('Valor')),
                      Expanded(flex: 2, child: Text('Vencimento')),
                      Expanded(flex: 2, child: Text('Status')),
                    ],
                  ),
                ),
                const Divider(),
                Spacing.x.verticalGap,
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.payments.length,
                    itemBuilder: (context, index) {
                      final payment = widget.payments[index];
                      return PaymentTile(paymnet: payment);
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: Padd.only(t: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: DropButton(),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: context.pop,
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
