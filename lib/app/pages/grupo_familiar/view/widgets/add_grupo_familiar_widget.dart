import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/view/store/edit_payment_store.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/group_member_tile.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/components/state_widget.dart';
import 'package:netinhoappclinica/core/helps/padding.dart';
import 'package:netinhoappclinica/core/helps/spacing.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../common/form/formatters/app_formatters.dart';
import '../../../../../core/components/app_form_field.dart';
import '../../../../../di/get_it.dart';
import '../../../gerenciar_pacientes/view/widgets/editar_buttons.dart';
import '../../../gerenciar_pacientes/view/widgets/excluir_buttons.dart';
import '../controller/add_group_controller.dart';
import '../controller/group_page_controller.dart';
import '../form/new_group_form.dart';
import '../store/get_group_members_store.dart';
import '../store/get_groups_store.dart';
import '../store/edit_groups_stores.dart';
import 'add_group_members_dialog.dart';

class AddGrupoFamiliarWidget extends StatefulWidget {
  final GetGroupsStore groupStore;
  const AddGrupoFamiliarWidget({
    Key? key,
    required this.groupStore,
  }) : super(key: key);

  @override
  State<AddGrupoFamiliarWidget> createState() => _AddGrupoFamiliarWidgetState();
}

class _AddGrupoFamiliarWidgetState extends State<AddGrupoFamiliarWidget> with SnackBarMixin {
  late final AddGroupStore generateGroupStore;

  late final GetGroupMembersStore membersStore;
  late final EditPaymentsStore editPaymentsStore;

  late final GroupPageController groupsController;
  late final AddGroupController addGroupController;

  @override
  void initState() {
    super.initState();
    generateGroupStore = getIt<AddGroupStore>();
    membersStore = getIt<GetGroupMembersStore>();
    editPaymentsStore = getIt<EditPaymentsStore>();
    groupsController = getIt<GroupPageController>();
    addGroupController = getIt<AddGroupController>();

    addGroupController.setFormListeners();
    membersStore.setEmptyMembers();
    generateGroupStore.addListener(storeListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addGroupController.setInitialPayDate();
  }

  @override
  void dispose() {
    super.dispose();
    generateGroupStore.removeListener(storeListener);
    groupsController.clearCompleteSearch();

    generateGroupStore.dispose();
    membersStore.dispose();
    editPaymentsStore.dispose();
  }

  void storeListener() {
    if (generateGroupStore.value.isSuccess) {
      resetForm();
      widget.groupStore.getGroups();
      showSuccess(context: context, text: 'Grupo criado com sucesso!');
    }
    if (generateGroupStore.value.isError) {
      final message = generateGroupStore.value.error.message;
      showError(context: context, text: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 10,
      color: context.colorsApp.backgroundCardColor,
      borderRadius: BorderRadius.circular(20),
      child: ValueListenableBuilder<NewGroupForm>(
          valueListenable: addGroupController.form,
          builder: (context, form, _) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFormField(
                        underline: true,
                        maxWidth: MediaQuery.of(context).size.width * .15,
                        hint: 'Nome do Grupo',
                        contentPadding: Padd.all(Spacing.s),
                        controller: addGroupController.groupNameCt,
                        validator: (_) => form.groupName.error?.exists,
                        isValid: form.groupName.isValid,
                        textStyle: context.textStyles.textPoppinsMedium.copyWith(
                          fontSize: 24,
                          color: ColorsApp.instance.blackColor,
                        ),
                        errorText: form.groupName.displayError?.message,
                      ),
                      const Spacer(),
                      ExcluirButton(
                        discardMode: true,
                        onPressed: resetForm,
                      ),
                      const SizedBox(width: 10),
                      AnimatedBuilder(
                        animation: generateGroupStore,
                        builder: (context, _) => EditarButton(
                          isLoading: generateGroupStore.value.isLoading,
                          isEditing: true,
                          onPressed: form.isValid ? onSave : null,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Gerenciar Pagamentos',
                    style: context.textStyles.textPoppinsMedium.copyWith(
                      fontSize: 24,
                      color: ColorsApp.instance.success,
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: addGroupController.newGroupMembers,
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
                          itemBuilder: (context, index) => GroupMemberTile(
                            member: members[index],
                            enableRemove: true,
                            onRemoveMember: () => addGroupController.removeMember = members[index],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      builder: (_) => AddGroupMembersDialog(
                        addController: addGroupController,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Gerenciar Pagamentos',
                    style: context.textStyles.textPoppinsMedium.copyWith(
                      fontSize: 24,
                      color: ColorsApp.instance.success,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppFormField(
                        labelText: 'Valor:',
                        controller: addGroupController.monthlyFee,
                        isValid: form.monthlyFee.isValid,
                        validator: (_) => form.monthlyFee.error?.exists,
                        errorText: form.monthlyFee.displayError?.message,
                        inputFormatters: [AppFormatters.onlyNumber, AppFormatters.currency],
                      ),
                      const SizedBox(width: 60),
                      AppFormField(
                        labelText: 'Vencimento:',
                        autofocus: true,
                        controller: addGroupController.payDateCt,
                        isValid: form.payDate.isValid,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (_) => form.payDate.error?.exists,
                        errorText: form.payDate.displayError?.message,
                        inputFormatters: [AppFormatters.date],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  void onSave() {
    generateGroupStore.generate(
      group: addGroupController.updateGroup(),
      paymnetModel: addGroupController.updatePayment(),
    );
  }

  void resetForm() {
    groupsController.toogleAddNewPatient = false;
    groupsController.groupSelected.value = null;
    addGroupController.resetValues();
  }
}
