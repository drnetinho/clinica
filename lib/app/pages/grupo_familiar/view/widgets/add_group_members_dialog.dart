import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/search_group_patients.dart';
import 'package:netinhoappclinica/core/helps/extension/list_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../../clinica_icons_icons.dart';
import '../../../../../core/components/state_widget.dart';
import '../../../../../core/helps/padding.dart';
import '../../../../../core/helps/spacing.dart';
import '../../../gerenciar_pacientes/domain/model/patient_model.dart';
import '../../../gerenciar_pacientes/view/store/manage_patient_store.dart';
import '../controller/add_group_controller.dart';
import '../controller/group_page_controller.dart';

class AddGroupMembersDialog extends StatefulWidget {
  final AddGroupController addController;

  const AddGroupMembersDialog({
    Key? key,
    required this.addController,
  }) : super(key: key);

  @override
  State<AddGroupMembersDialog> createState() => _AddGroupMembersDialogState();
}

class _AddGroupMembersDialogState extends State<AddGroupMembersDialog> {
  late final GroupPageController mainCtrl;
  late final ManagePatientsStore patientsStore;

  @override
  void initState() {
    super.initState();
    mainCtrl = getIt<GroupPageController>();
    patientsStore = getIt<ManagePatientsStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: Padd.sh(Spacing.x),
        height: MediaQuery.of(context).size.height * .8,
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
          children: [
            Spacing.xm.verticalGap,
            ValueListenableBuilder<List<PatientModel>>(
              valueListenable: patientsStore.undefiniedPatients,
              builder: (context, patientsList, _) {
                return AnimatedBuilder(
                  animation: mainCtrl.searchCt,
                  builder: (context, _) {
                    return SearchGroupPatients(
                      controller: mainCtrl.searchCt,
                      width: MediaQuery.of(context).size.width * .2,
                      patients: patientsList,
                      autoFocus: true,
                      searchByGroup: false,
                      findedPatients: (p) =>
                          p != null ? mainCtrl.addSearchPatients = p : mainCtrl.resetSearchPatients(),
                    );
                  },
                );
              },
            ),
            Spacing.xm.verticalGap,
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .35,
                child: ValueListenableBuilder<List<PatientModel>>(
                  valueListenable: patientsStore.undefiniedPatients,
                  builder: (context, patientsList, _) {
                    if (patientsList.isEmpty) {
                      return const StateEmptyWidget(
                        message: 'Não existem pacientes sem grupos.',
                      );
                    }
                    return AnimatedBuilder(
                        animation: widget.addController.newGroupMembers,
                        builder: (context, _) {
                          return ValueListenableBuilder(
                            valueListenable: mainCtrl.searchPatients,
                            builder: (context, search, _) {
                              List<PatientModel> patients = search ?? patientsList;
                              return ListView.builder(
                                itemCount: patients.length,
                                itemBuilder: (context, index) {
                                  final patient = patients[index];
                                  final memberIncluded = widget.addController.containsMember(patient.id);
                                  return ListTile(
                                    trailing: Checkbox(
                                      activeColor: context.colorsApp.primary,
                                      value: memberIncluded,
                                      onChanged: (v) => v == true ? addMember(patient) : removeMember(patient),
                                    ),
                                    title: Text(patient.name),
                                    leading: const Icon(ClinicaIcons.account_circle),
                                    selectedTileColor: context.colorsApp.greenColor,
                                    selectedColor: context.colorsApp.blackColor,
                                    onTap: () {
                                      !memberIncluded ? addMember(patient) : removeMember(patient);
                                    },
                                  );
                                },
                              );
                            },
                          );
                        });
                  },
                ),
              ),
            ),
            Spacing.xm.verticalGap,
            Container(
              alignment: Alignment.bottomRight,
              padding: Padd.all(Spacing.m),
              child: ValueListenableBuilder(
                valueListenable: widget.addController.newGroupMembers,
                builder: (context, newMembers, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: context.pop,
                        child: const Text('Cancelar'),
                      ),
                      Spacing.m.horizotalGap,
                      ElevatedButton(
                        onPressed: newMembers.exists ? context.pop : null,
                        child: const Text('Confirmar'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addMember(PatientModel member) => widget.addController.addMember = member;
  void removeMember(PatientModel member) => widget.addController.removeMember = member;
}
