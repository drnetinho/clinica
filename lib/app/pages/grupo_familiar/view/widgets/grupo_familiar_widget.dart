import 'package:clisp/app/pages/grupo_familiar/view/widgets/imprimir_carteira.dart';
import 'package:flutter/material.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:clisp/app/pages/grupo_familiar/view/controller/edit_group_controller.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/group_member_tile.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/grupo_familiar_footer.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/historic_button.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/wallet_button.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/helps/extension/list_extension.dart';
import 'package:clisp/core/helps/spacing.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/components/app_dialog.dart';
import '../../../../../core/components/app_form_field.dart';
import '../../../../../core/components/snackbar.dart';
import '../../../../../core/components/state_widget.dart';
import '../../../../../core/components/store_builder.dart';
import '../../../../../core/helps/padding.dart';
import '../../../../../di/get_it.dart';
import '../../../gerenciar_pacientes/view/store/manage_patient_store.dart';
import '../../../gerenciar_pacientes/view/widgets/editar_buttons.dart';
import '../../../gerenciar_pacientes/view/widgets/excluir_buttons.dart';
import '../../domain/model/family_payment_model.dart';
import '../controller/group_page_controller.dart';
import '../store/edit_payment_store.dart';
import '../store/get_group_members_store.dart';
import '../store/get_group_payments_store.dart';
import '../store/get_groups_store.dart';
import '../store/edit_groups_stores.dart';
import 'edit_group_members_dialog.dart';
import 'gerar_carne_widget.dart';
import 'payment_historic_dialog.dart';

class GrupoFamiliarWidget extends StatefulWidget {
  final FamilyGroupModel group;
  final GetGroupMembersStore membersStore;
  final GetGroupsStore groupStore;

  const GrupoFamiliarWidget({
    Key? key,
    required this.group,
    required this.membersStore,
    required this.groupStore,
  }) : super(key: key);

  @override
  State<GrupoFamiliarWidget> createState() => _GrupoFamiliarWidgetState();
}

class _GrupoFamiliarWidgetState extends State<GrupoFamiliarWidget> with SnackBarMixin {
  late final GetGroupPaymentsStore paymentsStore;
  late final EditPaymentsStore editPaymentsStore;
  late final DeleteGroupStore deleteGrupoStore;
  late final EditGroupStore editGroupStore;

  late final GroupPageController groupsController;
  late final EditGroupController editGroupController;
  late final ValueNotifier<bool> editMode;

  @override
  @override
  void initState() {
    super.initState();
    widget.membersStore.getGroupMembers(ids: widget.group.members);
    paymentsStore = getIt<GetGroupPaymentsStore>();
    editPaymentsStore = getIt<EditPaymentsStore>();
    editGroupController = getIt<EditGroupController>();
    deleteGrupoStore = getIt<DeleteGroupStore>();
    editGroupStore = getIt<EditGroupStore>();

    getPayments();

    groupsController = getIt<GroupPageController>();
    editMode = ValueNotifier(false);

    editMode.addListener(setupEditConfig);
    editGroupStore.addListener(editGroupStoreListener);
    editPaymentsStore.addListener(editPaymentStoreListener);
  }

  @override
  void didUpdateWidget(covariant GrupoFamiliarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.membersStore.getGroupMembers(ids: widget.group.members);
    getPayments();
  }

  @override
  void dispose() {
    super.dispose();
    editPaymentsStore.removeListener(editPaymentStoreListener);
    editMode.removeListener(setupEditConfig);
    editGroupStore.removeListener(editGroupStoreListener);

    paymentsStore.dispose();
    editPaymentsStore.dispose();
    deleteGrupoStore.dispose();
    editGroupStore.dispose();
    editMode.dispose();
  }

  void editPaymentStoreListener() {
    if (editPaymentsStore.value.isSuccess) {
      getPayments();
    }
    if (editPaymentsStore.value.isError) {
      final message = editPaymentsStore.value.error.message;
      showError(context: context, text: message);
    }
  }

  void editGroupStoreListener() {
    if (editGroupStore.value.isSuccess) {
      editMode.value = false;
      groupsController.groupSelected.value = null;
      widget.groupStore.getGroups();
      // TODO Artur observar viabilidade dessa chamada
      getIt<ManagePatientsStore>().getPatients();
      editGroupController.resetValues();
      showSuccess(context: context, text: 'Grupo editado com sucesso!');
    }

    if (editGroupStore.value.isError) {
      showError(context: context, text: editGroupStore.value.error.message);
    }
  }

  void setupEditConfig() {
    if (editMode.value) {
      editGroupController.setFormListeners();
      editGroupController.selectedGroup.value = widget.group;
      editGroupController.groupNameCt.text = widget.group.name;

      if (widget.membersStore.value.isSuccess) {
        for (var member in widget.membersStore.value.success.data as List<PatientModel>) {
          editGroupController.addMember = member;
        }
      }
    }
  }

  void getPayments() => paymentsStore.getGroupPayments(id: widget.group.id);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: editGroupController.form,
      builder: (context, form, _) {
        return ValueListenableBuilder(
          valueListenable: editMode,
          builder: (context, isEditing, _) {
            final state = isEditing ? CrossFadeState.showSecond : CrossFadeState.showFirst;
            return PhysicalModel(
              elevation: 10,
              color: context.colorsApp.backgroundCardColor,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AnimatedCrossFade(
                          firstChild: Text(
                            widget.group.name,
                            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 22),
                          ),
                          secondChild: AppFormField(
                            underline: true,
                            maxWidth: MediaQuery.of(context).size.width * .15,
                            hint: 'Nome do Grupo',
                            contentPadding: Padd.all(Spacing.s),
                            controller: editGroupController.groupNameCt,
                            validator: (_) => form.groupName.error?.exists,
                            isValid: form.groupName.isValid,
                            textStyle: context.textStyles.textPoppinsMedium.copyWith(
                              fontSize: 24,
                              color: ColorsApp.instance.blackColor,
                            ),
                            errorText: form.groupName.displayError?.message,
                          ),
                          crossFadeState: state,
                          duration: kThemeAnimationDuration,
                        ),
                        const Spacer(),
                        ExcluirButton(
                          discardMode: isEditing,
                          onPressed: isEditing
                              ? turnOffEditMode
                              : () => showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (_) => AppDialog(
                                      title: 'Deseja realmente excluir o Grupo ${widget.group.name}?',
                                      firstButtonText: 'Cancelar',
                                      secondButtonText: 'Excluir',
                                      firstButtonBackgroudColor: context.colorsApp.dartWhite,
                                      secondButtonBackgroudColor: context.colorsApp.danger,
                                      width: 600,
                                      firstButtonIcon: Icons.cancel,
                                      secondButtonIcon: Icons.delete,
                                      store: deleteGrupoStore,
                                      popOnSuccess: true,
                                      onPressedSecond: () => deleteGrupoStore.delete(group: widget.group),
                                      actionOnSuccess: () {
                                        groupsController.groupSelected.value = null;
                                        widget.groupStore.getGroups();
                                      },
                                    ),
                                  ),
                        ),
                        const SizedBox(width: 10),
                        AnimatedBuilder(
                          animation: editGroupStore,
                          builder: (context, _) => EditarButton(
                            isLoading: editGroupStore.value.isLoading,
                            isEditing: isEditing,
                            onPressed: isEditing ? onSave : turnOnEditMode,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: editGroupController.members,
                          builder: (context, editingMembers, _) {
                            return StoreBuilder<List<PatientModel>>(
                              store: widget.membersStore,
                              validateEmptyList: false,
                              builder: (context, storeMembers, child) {
                                final members = isEditing ? editingMembers : storeMembers;
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
                                    return GroupMemberTile(
                                      member: members[index],
                                      enableRemove: isEditing,
                                      onRemoveMember: () => onRemoveMember(members[index]),
                                    );
                                  },
                                );
                              },
                            );
                          }),
                    ),
                    if (isEditing) ...{
                      InkWell(
                        child: Text(
                          '+ Adicionar paciente',
                          style: context.textStyles.textPoppinsMedium.copyWith(
                            fontSize: 18,
                            color: ColorsApp.instance.success,
                          ),
                        ),
                        onTap: () => showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (_) => EditGroupMembersDialog(
                            editController: editGroupController,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    },
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Histórico de Pagamentos',
                          style: context.textStyles.textPoppinsMedium.copyWith(
                            fontSize: 24,
                            color: ColorsApp.instance.success,
                          ),
                        ),
                        StoreBuilder<List<FamilyPaymnetModel>>(
                          store: paymentsStore,
                          validateDefaultStates: false,
                          builder: (context, payments, _) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              width: 100,
                              decoration: BoxDecoration(
                                color: getColorStatus(payments),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                getTextStatus(payments),
                                style: context.textStyles.textPoppinsRegular.copyWith(
                                  fontSize: 14,
                                  color: context.colorsApp.whiteColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ],
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
                            onConfirmDelete: () => showDialog(
                              useSafeArea: true,
                              context: context,
                              builder: (_) => AppDialog(
                                title: 'Deseja realmente salvar as alterações?',
                                firstButtonText: 'Cancelar',
                                secondButtonText: 'Deletar',
                                firstButtonIcon: Icons.close,
                                secondButtonIcon: Icons.delete,
                                firstButtonBackgroudColor: context.colorsApp.dartWhite,
                                secondButtonBackgroudColor: context.colorsApp.danger,
                                store: editPaymentsStore,
                                onPressedSecond: () => editPaymentsStore.delete(payment: lastPayment),
                              ),
                            ),
                            onConfirmRevert: () => showDialog(
                              useSafeArea: true,
                              context: context,
                              builder: (_) => AppDialog(
                                title: 'Deseja realmente salvar as alterações?',
                                description: 'Ao reverter este pagamento o status dele irá ser definido como Pendente.',
                                firstButtonText: 'Cancelar',
                                secondButtonText: 'Reverter',
                                firstButtonIcon: Icons.close,
                                secondButtonIcon: Icons.check,
                                firstButtonBackgroudColor: context.colorsApp.dartWhite,
                                secondButtonBackgroudColor: context.colorsApp.danger,
                                store: editPaymentsStore,
                                onPressedSecond: () => editPaymentsStore.revert(payment: lastPayment),
                              ),
                            ),
                            onConfirmReceive: () => showDialog(
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
                                thirdButtonIcon: Icons.add,
                                firstButtonBackgroudColor: context.colorsApp.dartWhite,
                                secondButtonBackgroudColor: context.colorsApp.success,
                                thirdButtonBackgroudColor: context.colorsApp.success,
                                store: editPaymentsStore,
                                width: 600,
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Nenhum pagamento identificado'),
                              Spacing.m.verticalGap,
                              ElevatedButton(
                                onPressed: () => editPaymentsStore.generate(groupId: widget.group.id),
                                child: const Text('Gerar parcela'),
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HistoricButton(
                                  onTap: () => showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (_) => PaymentHistoricDialog(
                                      paymentsStore: paymentsStore,
                                      onRefresh: getPayments,
                                    ),
                                  ),
                                ),
                                const ImprimirCarteirinhaWidget(),
                                const GerarCarneWidget(),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    StoreBuilder<List<PatientModel>>(
                      store: widget.membersStore,
                      validateDefaultStates: false,
                      builder: (context, members, child) {
                        return Center(
                          child: WalletButton(
                            enabled: members.exists,
                            onTap: () {
                              showDialog(
                                useSafeArea: true,
                                context: context,
                                builder: (context) => const ImprimirCarteirinhaWidget(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void turnOffEditMode() {
    editMode.value = false;
    editGroupController.resetValues();
  }

  void onSave() {
    editGroupStore.edit(
      group: editGroupController.updateGroup(),
      oldMembers: widget.group.members,
    );
  }

  void onRemoveMember(PatientModel member) => editGroupController.removeMember = member;

  void turnOnEditMode() => editMode.value = true;

  String getTextStatus(List<FamilyPaymnetModel> payments) {
    if (payments.isEmpty) {
      return 'A definir';
    } else {
      return paymentsStore.isPending(payments) ? 'Pendende' : 'Pago';
    }
  }

  Color getColorStatus(List<FamilyPaymnetModel> payments) {
    if (payments.isEmpty) {
      return ColorsApp.instance.warning;
    } else {
      return paymentsStore.isPending(payments) ? ColorsApp.instance.danger : ColorsApp.instance.primary;
    }
  }
}
