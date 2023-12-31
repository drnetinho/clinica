import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:clisp/app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import 'package:clisp/app/pages/grupo_familiar/view/store/edit_payment_store.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/payment_tile.dart';
import 'package:clisp/core/components/drop_filter.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/di/get_it.dart';

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
  void dispose() {
    filteredPayments.dispose();
    editPaymentsStore.dispose();
    super.dispose();
  }

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

  TextStyle get _textStyle => TextStyle(
        color: context.colorsApp.blackColor,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Text('Valor', style: _textStyle)),
                            Expanded(flex: 2, child: Text('Vencimento', style: _textStyle)),
                            Expanded(flex: 2, child: Text('Status da Parcela', style: _textStyle)),
                            Expanded(flex: 2, child: Text('Recebimento', style: _textStyle)),
                            const Expanded(flex: 1, child: Text('')),
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
                                    onCreate: () => editPaymentsStore.generateNextPayment(
                                      oldPaymenteBase: payment,
                                    ),
                                    onConfirmPayment: () => showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (_) => AppDialog(
                                        title: 'Deseja realmente salvar as alterações?',
                                        description:
                                            'Você pode apenas confirmar o pagamento atual, ou pode confirmar e gerar automaticamente o próximo pagamento.',
                                        firstButtonText: 'Cancelar',
                                        secondButtonText: 'Apenas confirmar',
                                        thirdButtonText: 'Confirmar e criar',
                                        firstButtonIcon: Icons.close,
                                        secondButtonIcon: Icons.check,
                                        thirdButtonIcon: Icons.create,
                                        firstButtonBackgroudColor: context.colorsApp.dartWhite,
                                        secondButtonBackgroudColor: context.colorsApp.success,
                                        thirdButtonBackgroudColor: context.colorsApp.success,
                                        store: editPaymentsStore,
                                        width: 600,
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
                                        firstButtonIcon: Icons.close,
                                        secondButtonIcon: Icons.check,
                                        secondButtonBackgroudColor: context.colorsApp.danger,
                                        firstButtonBackgroudColor: context.colorsApp.dartWhite,
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
                                        secondButtonBackgroudColor: context.colorsApp.danger,
                                        firstButtonBackgroudColor: context.colorsApp.dartWhite,
                                        firstButtonIcon: Icons.close,
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
                            child: DropFilter(
                              selectedValue: (filter) => filteredPayments.value = filterController.filterPayments(
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
                              icon: const Icon(Icons.close),
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
