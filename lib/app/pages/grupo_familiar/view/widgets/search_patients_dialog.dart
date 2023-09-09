import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/search_dialog_filter_buttons.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/search_group_patients.dart';
import 'package:netinhoappclinica/core/helps/extension/value_notifier_extension.dart';
import 'package:netinhoappclinica/core/helps/padding.dart';
import 'package:netinhoappclinica/core/helps/spacing.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';

import '../controller/grupo_familiar_controller.dart';

class SearchPatientsDialog extends StatefulWidget {
  final GrupoFamiliarController controller;
  final List<PatientModel> patients;
  final List<FamilyGroupModel> groups;
  final Function(FamilyGroupModel?) selectedGroup;

  const SearchPatientsDialog({
    Key? key,
    required this.controller,
    required this.patients,
    required this.groups,
    required this.selectedGroup,
  }) : super(key: key);

  @override
  State<SearchPatientsDialog> createState() => _SearchPatientsDialogState();
}

class _SearchPatientsDialogState extends State<SearchPatientsDialog> {
  late final ValueNotifier<bool> searchByGroup;
  late final ValueNotifier<FamilyGroupModel?> selectedGroup;

  @override
  void initState() {
    super.initState();
    searchByGroup = ValueNotifier(true);
    selectedGroup = ValueNotifier(null);
  }

  GrupoFamiliarController get ctrl => widget.controller;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: searchByGroup,
      builder: (context, filterByGroup, _) {
        return Dialog(
          child: Container(
            padding: Padd.sh(Spacing.x),
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              children: [
                Spacing.xm.verticalGap,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: ctrl.searchCt,
                      builder: (context, _) {
                        return SearchGroupPatients(
                          controller: ctrl.searchCt,
                          width: MediaQuery.of(context).size.width * .2,
                          patients: widget.patients,
                          groups: widget.groups,
                          autoFocus: true,
                          searchByGroup: filterByGroup,
                          findedGroups: (g) => g != null ? ctrl.addsearchGroups = g : ctrl.resetSearchGroups(),
                          findedPatients: (p) => p != null ? ctrl.addSearchPatients = p : ctrl.resetSearchPatients(),
                        );
                      },
                    ),
                    Spacing.m.horizotalGap,
                    SearchDialogFilterButtons(
                      groupIsSelected: filterByGroup,
                      onChanged: (filter) {
                        ctrl.clearCompleteSearch();
                        return searchByGroup.value = filter;
                      },
                    )
                  ],
                ),
                Spacing.xm.verticalGap,
                if (searchByGroup.value) ...{
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: ValueListenableBuilder(
                        valueListenable: ctrl.searchGroups,
                        builder: (context, search, _) {
                          List<FamilyGroupModel> groups = search ?? widget.groups;
                          return ListView.builder(
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              final group = groups[index];

                              return AnimatedBuilder(
                                animation: selectedGroup,
                                builder: (context, _) {
                                  return ListTile(
                                    title: Text(group.name),
                                    selectedTileColor: context.colorsApp.greenColor,
                                    selectedColor: context.colorsApp.blackColor,
                                    onTap: () {
                                      if (selectedGroup.value != group) {
                                        selectedGroup.value = group;
                                      } else {
                                        selectedGroup.value = null;
                                      }
                                    },
                                    selected: selectedGroup.exists && selectedGroup.value == group,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                } else ...{
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: ValueListenableBuilder(
                        valueListenable: ctrl.searchPatients,
                        builder: (context, search, _) {
                          List<PatientModel> patients = search ?? widget.patients;
                          return ListView.builder(
                            itemCount: patients.length,
                            itemBuilder: (context, index) {
                              final patient = patients[index];

                              final group = widget.groups.firstWhereOrNull(
                                (group) => group.id == patient.familyGroup,
                              );

                              if (group == null) {
                                return const SizedBox.shrink();
                              }

                              return AnimatedBuilder(
                                animation: selectedGroup,
                                builder: (context, _) {
                                  return ListTile(
                                    title: Text(patient.name),
                                    leading: const Icon(Icons.family_restroom),
                                    selectedTileColor: context.colorsApp.greenColor,
                                    selectedColor: context.colorsApp.blackColor,
                                    subtitle: Text(group.name),
                                    onTap: () {
                                      if (selectedGroup.value != group) {
                                        selectedGroup.value = group;
                                      } else {
                                        selectedGroup.value = null;
                                      }
                                    },
                                    selected: selectedGroup.exists && selectedGroup.value == group,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                },
                Spacing.xm.verticalGap,
                Container(
                  alignment: Alignment.bottomRight,
                  padding: Padd.all(Spacing.m),
                  child: AnimatedBuilder(
                    animation: selectedGroup,
                    builder: (context, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: context.pop,
                            child: const Text('Cancelar'),
                          ),
                          Spacing.m.horizotalGap,
                          ElevatedButton(
                            onPressed: selectedGroup.value != null
                                ? () {
                                    widget.selectedGroup.call(selectedGroup.value);
                                    context.pop();
                                  }
                                : null,
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
      },
    );
  }
}
