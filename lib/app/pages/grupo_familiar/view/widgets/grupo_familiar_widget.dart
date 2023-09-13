import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/clisp_wallet.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/group_member_tile.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/grupo_familiar_footer.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/historic_button.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/wallet_button.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/list_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/components/app_dialog.dart';
import '../../../../../core/components/state_widget.dart';
import '../../../../../core/components/store_builder.dart';
import '../../../../../di/get_it.dart';
import '../../../gerenciar_pacientes/view/widgets/editar_buttons.dart';
import '../../../gerenciar_pacientes/view/widgets/excluir_buttons.dart';
import '../../domain/model/family_payment_model.dart';
import '../store/manage_grupo_familiar_store.dart';
import '../store/edit_payment_store.dart';
import '../store/group_members_store.dart';
import '../store/group_payments_store.dart';
import 'payment_historic_dialog.dart';

class GrupoFamiliarWidget extends StatefulWidget {
  final FamilyGroupModel group;
  final GroupMembersStore membersStore;

  const GrupoFamiliarWidget({
    super.key,
    required this.group,
    required this.membersStore,
  });

  @override
  State<GrupoFamiliarWidget> createState() => _GrupoFamiliarWidgetState();
}

class _GrupoFamiliarWidgetState extends State<GrupoFamiliarWidget> {
  late final GroupPaymentsStore paymentsStore;
  late final EditPaymentsStore editPaymentsStore;
  late final ManageGrupoFamiliarStore editGrupoStore;
  late final ValueNotifier<bool> isEditing;

  @override
  void initState() {
    super.initState();
    widget.membersStore.getGroupMembers(ids: widget.group.members);
    paymentsStore = getIt<GroupPaymentsStore>();
    editPaymentsStore = getIt<EditPaymentsStore>();
    editGrupoStore = getIt<ManageGrupoFamiliarStore>();
    isEditing = ValueNotifier(false);
    getPayments();

    editPaymentsStore.addListener(() {
      if (editPaymentsStore.value.isSuccess) {
        getPayments();
      }
    });
  }

  @override
  void didUpdateWidget(covariant GrupoFamiliarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.membersStore.getGroupMembers(ids: widget.group.members);
    getPayments();
  }

  void getPayments() => paymentsStore.getGroupPayments(id: widget.group.id);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isEditing,
        builder: (context, isEditing, _) {
          return Card(
            color: context.colorsApp.backgroundCardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.group.name,
                        style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 22),
                      ),
                      const Spacer(),
                      ExcluirButton(
                        onPressed: () => showDialog(
                          useSafeArea: true,
                          context: context,
                          // TODO Thiago Personalizar este DIALOG abaixo
                          builder: (_) => AppDialog(
                            title: 'Deseja realmente excluir o Grupo ${widget.group.name}?',
                            firstButtonText: 'Cancelar',
                            secondButtonText: 'Excluir',
                            firstButtonIcon: Icons.cancel,
                            secondButtonIcon: Icons.delete,
                            store: editPaymentsStore,
                            onPressedSecond: () => editGrupoStore.delete(group: widget.group),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      EditarButton(
                        isEditing: isEditing,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: StoreBuilder<List<PatientModel>>(
                      store: widget.membersStore,
                      validateEmptyList: false,
                      builder: (context, members, child) {
                        if (members.isEmpty) {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StateEmptyWidget(
                                message: 'O Grupo ainda não possui membros',
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: members.length,
                          itemBuilder: (context, index) {
                            return GroupMemberTile(member: members[index]);
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    'Histórico de Pagamentos',
                    style: context.textStyles.textPoppinsMedium.copyWith(
                      fontSize: 24,
                      color: ColorsApp.instance.success,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StoreBuilder<List<FamilyPaymnetModel>>(
                    store: paymentsStore,
                    validateDefaultStates: false,
                    builder: (context, payments, _) {
                      if (payments.exists) {
                        final lastPayment = paymentsStore.actualPayment(payments) ?? payments.first;

                        return GrupoFamiliarFooter(
                          group: widget.group,
                          lastPayment: lastPayment,
                          onConfirmReceive: () => showDialog(
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
                                payment: lastPayment,
                                generateNext: false,
                              ),
                              onPressedThird: () => editPaymentsStore.confirmPending(
                                payment: lastPayment,
                                generateNext: true,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  StoreBuilder<List<FamilyPaymnetModel>>(
                      store: paymentsStore,
                      validateDefaultStates: false,
                      builder: (context, payments, _) {
                        if (!payments.exists) {
                          return const Text('Nenhum pagamento identificado');
                        }
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            HistoricButton(
                              onTap: () => showDialog(
                                useSafeArea: true,
                                context: context,
                                // TODO Thiago Personalizar este DIALOG abaixo
                                builder: (_) => PaymentHistoricDialog(
                                  paymentsStore: paymentsStore,
                                  onRefresh: getPayments,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  const SizedBox(height: 20),
                  StoreBuilder<List<PatientModel>>(
                    store: widget.membersStore,
                    validateDefaultStates: false,
                    builder: (context, members, child) {
                      return Center(
                        child: WalletButton(
                          enabled: members.exists,
                          onTap: () => showDialog(
                            useSafeArea: true,
                            context: context,
                            // TODO Thiago Personalizar este DIALOG abaixo
                            builder: (_) => ClispWallet(
                              groupName: widget.group.name,
                              members: members,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
