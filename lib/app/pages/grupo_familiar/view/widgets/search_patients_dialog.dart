import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/search_dialog_filter_buttons.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/search_group_patients.dart';
import 'package:clisp/core/helps/extension/value_notifier_extension.dart';
import 'package:clisp/core/helps/padding.dart';
import 'package:clisp/core/helps/spacing.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../clinica_icons_icons.dart';
import '../controller/group_page_controller.dart';

class SearchPatientsDialog extends StatefulWidget {
  final GroupPageController controller;
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
  void dispose() {
    searchByGroup.dispose();
    selectedGroup.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchByGroup = ValueNotifier(true);
    selectedGroup = ValueNotifier(null);
  }

  GroupPageController get ctrl => widget.controller;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: searchByGroup,
      builder: (context, filterByGroup, _) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            color: context.colorsApp.backgroundCardColor,
            padding: Padd.sh(Spacing.x),
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              children: [
                Spacing.xm.verticalGap,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    const Spacer(),
                    SearchDialogFilterButtons(
                      groupIsSelected: filterByGroup,
                      onChanged: (filter) {
                        ctrl.clearCompleteSearch();
                        return searchByGroup.value = filter;
                      },
                    ),
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
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              final group = groups[index];

                              return AnimatedBuilder(
                                animation: selectedGroup,
                                builder: (context, _) {
                                  return ListTile(
                                    title: Text(group.name),
                                    selectedTileColor: context.colorsApp.greenColor.withOpacity(.2),
                                    selectedColor: context.colorsApp.blackColor,
                                    leading: SizedBox(
                                      width: 90,
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Radio(
                                              activeColor: context.colorsApp.primary,
                                              value: group.id,
                                              groupValue: selectedGroup.value?.id,
                                              onChanged: (value) {
                                                if (selectedGroup.value != group) {
                                                  selectedGroup.value = group;
                                                } else {
                                                  selectedGroup.value = null;
                                                }
                                              },
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: context.colorsApp.whiteColor,
                                                borderRadius: BorderRadius.circular(50),
                                                border: Border.all(color: context.colorsApp.primary, width: 2),
                                              ),
                                              child:
                                                  Icon(ClinicaIcons.family, color: context.colorsApp.primary, size: 26),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                    leading: SizedBox(
                                      width: 90,
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Radio(
                                              activeColor: context.colorsApp.primary,
                                              value: patient.familyGroup,
                                              groupValue: selectedGroup.value?.id,
                                              onChanged: (value) {
                                                if (selectedGroup.value != group) {
                                                  selectedGroup.value = group;
                                                } else {
                                                  selectedGroup.value = null;
                                                }
                                              },
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(ClinicaIcons.account_circle,
                                                size: 40, color: context.colorsApp.primary),
                                          ],
                                        ),
                                      ),
                                    ),
                                    selectedTileColor: context.colorsApp.greenColor.withOpacity(.2),
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
                  margin: Padd.all(Spacing.m),
                  child: AnimatedBuilder(
                    animation: selectedGroup,
                    builder: (context, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: context.colorsApp.dartWhite),
                            onPressed: () {
                              context.pop();
                              ctrl.clearCompleteSearch();
                            },
                            child: Row(
                              children: [
                                Icon(Icons.close, color: context.colorsApp.blackColor),
                                const SizedBox(height: 10),
                                Text('Cancelar',
                                    style: context.textStyles.textPoppinsSemiBold
                                        .copyWith(color: context.colorsApp.blackColor)),
                              ],
                            ),
                          ),
                          Spacing.m.horizotalGap,
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: context.colorsApp.primary),
                            onPressed: selectedGroup.value != null
                                ? () {
                                    widget.selectedGroup.call(selectedGroup.value);
                                    context.pop();
                                  }
                                : null,
                            child: Row(
                              children: [
                                Icon(Icons.check, color: context.colorsApp.whiteColor),
                                const SizedBox(height: 10),
                                Text('Confirmar',
                                    style: context.textStyles.textPoppinsSemiBold
                                        .copyWith(color: context.colorsApp.whiteColor)),
                              ],
                            ),
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
