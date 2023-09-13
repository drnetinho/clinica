import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/store/edit_payment_store.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/group_member_tile.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/state_widget.dart';
import 'package:netinhoappclinica/core/helps/padding.dart';
import 'package:netinhoappclinica/core/helps/spacing.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../common/form/formatters/app_formatters.dart';
import '../../../../../core/components/app_form_field.dart';
import '../../../../../core/components/store_builder.dart';
import '../../../../../di/get_it.dart';
import '../../../gerenciar_pacientes/domain/model/patient_model.dart';
import '../../../gerenciar_pacientes/view/widgets/editar_buttons.dart';
import '../../../gerenciar_pacientes/view/widgets/excluir_buttons.dart';
import '../controller/add_grupo_familiar_controller.dart';
import '../controller/grupo_familiar_controller.dart';
import '../form/new_group_form.dart';
import '../store/manage_grupo_familiar_store.dart';
import '../store/group_members_store.dart';

class AddGrupoFamiliarWidget extends StatefulWidget {
  const AddGrupoFamiliarWidget({super.key});

  @override
  State<AddGrupoFamiliarWidget> createState() => _AddGrupoFamiliarWidgetState();
}

class _AddGrupoFamiliarWidgetState extends State<AddGrupoFamiliarWidget> {
  late final ManageGrupoFamiliarStore manageGroupsStore;
  late final GroupMembersStore membersStore;
  late final EditPaymentsStore editPaymentsStore;

  late final GrupoFamiliarController groupsController;
  late final AddGrupoFamiliarController addGroupController;

  @override
  void initState() {
    super.initState();
    manageGroupsStore = getIt<ManageGrupoFamiliarStore>();
    membersStore = getIt<GroupMembersStore>();
    editPaymentsStore = getIt<EditPaymentsStore>();
    groupsController = getIt<GrupoFamiliarController>();
    addGroupController = getIt<AddGrupoFamiliarController>();

    addGroupController.setFormListeners();
    membersStore.setEmptyMembers();

    manageGroupsStore.addListener(() {
      if (manageGroupsStore.value.isSuccess) {
        // editPaymentsStore.generate(
        //   familyGroupId: addGroupController.newGroup.value.id,
        // );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorsApp.backgroundCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
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
                        autofocus: true,
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
                        onPressed: () {
                          toogleOffAddNewGroup();
                          addGroupController.resetValues();
                        },
                      ),
                      const SizedBox(width: 10),
                      EditarButton(
                        isEditing: true,
                        onPressed: form.isValid
                            ? () {
                                if (form.isValid) {
                                  manageGroupsStore.generate(
                                    group: addGroupController.updateGroup(),
                                  );
                                }
                              }
                            : null,
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
                  const Spacer(),
                  Expanded(
                    child: StoreBuilder<List<PatientModel>>(
                      store: membersStore,
                      validateEmptyList: true,
                      empty: const StateEmptyWidget(
                        message: 'O Grupo ainda não possui membros',
                      ),
                      builder: (context, members, child) {
                        return ValueListenableBuilder(
                          valueListenable: addGroupController.newGroupMembers,
                          builder: (contex, newMembers, _) {
                            return ListView.separated(
                              separatorBuilder: (_, __) => const Divider(),
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemCount: members.length,
                              itemBuilder: (context, index) => GroupMemberTile(member: members[index]),
                            );
                          },
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
                    onTap: () {},
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

  void toogleOffAddNewGroup() => groupsController.toogleAddNewPatient = false;
}
