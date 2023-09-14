import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/store/edit_payment_store.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/payment_tile.dart';
import 'package:netinhoappclinica/app/pages/historico/widgets/drop_button.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../../core/components/app_dialog.dart';
import '../../../../../core/components/store_builder.dart';
import '../../../../../core/helps/actual_date.dart';
import '../../../../../core/helps/padding.dart';
import '../../../../../core/helps/spacing.dart';
import '../controller/filter_controller.dart';
import '../store/get_group_payments_store.dart';

class PaymentHistoricDialog extends StatefulWidget {
  final GetGroupPaymentsStore paymentsStore;
  final VoidCallback onRefresh;

  const PaymentHistoricDialog({
    Key? key,
    required this.paymentsStore,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<PaymentHistoricDialog> createState() => _PaymentHistoricDialogState();
}

class _PaymentHistoricDialogState extends State<PaymentHistoricDialog> {
  late final EditPaymentsStore editPaymentsStore;
  late final FilterController filterController;
  late final ValueNotifier<List<FamilyPaymnetModel>?> filteredPayments;

  @override
  void initState() {
    super.initState();
    editPaymentsStore = getIt<EditPaymentsStore>();
    filterController = getIt<FilterController>();
    filteredPayments = ValueNotifier(null);

    editPaymentsStore.addListener(() {
      if (editPaymentsStore.value.isSuccess) {
        widget.onRefresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: Padd.sh(Spacing.x),
        height: MediaQuery.of(context).size.height * .8,
        width: MediaQuery.of(context).size.width * .4,
        child: StoreBuilder<List<FamilyPaymnetModel>>(
            store: widget.paymentsStore,
            validateDefaultStates: true,
            builder: (context, payments, _) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: Padd.only(t: 150),
                        child: const Row(
                          children: [
                            Expanded(flex: 2, child: Text('Valor')),
                            Expanded(flex: 2, child: Text('Vencimento')),
                            Expanded(flex: 2, child: Text('Recebimento')),
                            Expanded(flex: 2, child: Text('Status')),
                            Expanded(flex: 2, child: Text('Gerenciar')),
                          ],
                        ),
                      ),
                      const Divider(),
                      Spacing.x.verticalGap,
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: filteredPayments,
                            builder: (context, filtered, _) {
                              final filteredList = filtered ?? payments;
                              return ListView.separated(
                                separatorBuilder: (_, __) => Spacing.m.verticalGap,
                                itemCount: filteredList.length,
                                itemBuilder: (context, index) {
                                  final payment = filteredList[index];
                                  return PaymentTile(
                                    paymnet: payment,
                                    onConfirmPayment: () => showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      // TODO Thiago Personalizar este DIALOG abaixo
                                      builder: (_) => AppDialog(
                                        title: 'Deseja realmente salvar as alterações?',
                                        description:
                                            'Você pode apenas confirmar o pagamento atual, ou pode confirmar e gerar automaticamente o próximo pagamento.',
                                        firstButtonText: 'Cancelar',
                                        secondButtonText: 'Apenas confirmar',
                                        thirdButtonText: 'Confirmar e criar',
                                        firstButtonIcon: Icons.cancel,
                                        secondButtonIcon: Icons.check,
                                        thirdButtonIcon: Icons.create,
                                        store: editPaymentsStore,
                                        onPressedSecond: () => editPaymentsStore.confirmPending(
                                          payment: payment,
                                          generateNext: false,
                                        ),
                                        onPressedThird: () => editPaymentsStore.confirmPending(
                                          payment: payment,
                                          generateNext: true,
                                        ),
                                      ),
                                    ),
                                    onRevertPayment: () => showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (_) => AppDialog(
                                        title: 'Deseja realmente salvar as alterações?',
                                        description:
                                            'Ao reverter este pagamento o status dele irá ser definido como Pendente.',
                                        firstButtonText: 'Cancelar',
                                        secondButtonText: 'Reverter',
                                        firstButtonIcon: Icons.cancel,
                                        secondButtonIcon: Icons.check,
                                        store: editPaymentsStore,
                                        onPressedSecond: () => editPaymentsStore.revert(payment: payment),
                                      ),
                                    ),
                                    onDeletePayment: () => showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (_) => AppDialog(
                                        title: 'Deseja realmente salvar as alterações?',
                                        firstButtonText: 'Cancelar',
                                        secondButtonText: 'Deletar',
                                        firstButtonIcon: Icons.cancel,
                                        secondButtonIcon: Icons.delete,
                                        store: editPaymentsStore,
                                        onPressedSecond: () => editPaymentsStore.delete(payment: payment),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: DropButton(
                              selectedValue: (filter) => filteredPayments.value = filterController.filter(
                                payments,
                                filter,
                                KCurrentDate,
                              ),
                            ),
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
              );
            }),
      ),
    );
  }
}
