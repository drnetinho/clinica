import 'package:flutter/material.dart';

import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:clisp/app/pages/grupo_familiar/view/store/get_group_members_store.dart';
import 'package:clisp/app/pages/grupo_familiar/view/store/get_group_payments_store.dart';
import 'package:clisp/app/pages/grupo_familiar/view/store/get_groups_store.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/add_grupo_familiar_widget.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/family_group_tile.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/grupo_familiar_widget.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/search_group_patients.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/search_patients_dialog.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:clisp/di/get_it.dart';

import '../../../../core/components/state_widget.dart';
import '../../../../core/components/store_builder.dart';
import '../../gerenciar_pacientes/view/store/manage_patient_store.dart';
import 'controller/group_page_controller.dart';

class GrupoFamiliarPage extends StatefulWidget {
  static const String routeName = 'grupofamiliar';
  const GrupoFamiliarPage({Key? key}) : super(key: key);

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarPageState();
}

class _GrupoFamiliarPageState extends State<GrupoFamiliarPage> {
  late final GetGroupsStore groupStore;
  late final GetGroupMembersStore membersStore;
  late final ManagePatientsStore managePatientsStore;
  late final GroupPageController controller;
  late final GetGroupPaymentsStore paymnetsStore;

  @override
  void initState() {
    super.initState();
    groupStore = getIt<GetGroupsStore>();
    membersStore = getIt<GetGroupMembersStore>();
    managePatientsStore = getIt<ManagePatientsStore>();
    paymnetsStore = getIt<GetGroupPaymentsStore>();
    controller = getIt<GroupPageController>();

    managePatientsStore.getPatients();
    if (!groupStore.value.isSuccess) {
      groupStore.getGroups();
      //
    }
  }

  @override
  void dispose() {
    controller.clearCompleteSearch();
    controller.resetSelectedGroup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(80, 30, 80, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grupo Familiar',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    // * SEARCH HEADER
                    StoreBuilder<List<FamilyGroupModel>>(
                      store: groupStore,
                      validateDefaultStates: false,
                      builder: (context, groups, child) {
                        return StoreBuilder<List<PatientModel>>(
                          store: managePatientsStore,
                          validateDefaultStates: false,
                          builder: (context, patients, _) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * .1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SearchGroupPatients(
                                    patients: const [],
                                    groups: const [],
                                    searchByGroup: false,
                                    width: MediaQuery.of(context).size.width * .18,
                                    onTap: () => showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (_) => SearchPatientsDialog(
                                        controller: controller,
                                        patients: patients,
                                        groups: groups,
                                        selectedGroup: (selectedGroup) {
                                          if (selectedGroup != null) {
                                            controller.groupSelected.value = selectedGroup;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () => controller.toogleAddNewPatient = true,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add, size: 16, color: ColorsApp.instance.whiteColor),
                                          const SizedBox(width: 10),
                                          Text('Novo Grupo',
                                              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    // * LIST OF GROUPS
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width * .32,
                      child: PhysicalModel(
                        elevation: 10,
                        color: context.colorsApp.backgroundCardColor,
                        borderRadius: BorderRadius.circular(20),
                        child: StoreBuilder<List<PatientModel>>(
                            store: managePatientsStore,
                            validateDefaultStates: true,
                            builder: (context, __, _) {
                              return StoreBuilder<List<FamilyGroupModel>>(
                                store: groupStore,
                                builder: (context, groups, child) {
                                  if (groups.isEmpty) {
                                    return const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        StateEmptyWidget(
                                          icon: Icons.group_add,
                                          message: 'Não existem grupos cadastrados.',
                                        ),
                                      ],
                                    );
                                  }
                                  return ValueListenableBuilder(
                                    valueListenable: controller.groupSelected,
                                    builder: (context, groupSelected, _) {
                                      return ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: groups.length,
                                        itemBuilder: (context, index) {
                                          final group = groups[index];

                                          return InkWell(
                                            onTap: () => controller.groupSelected.value = group,
                                            child: FamilyGroupTile(
                                              group: group,
                                              isSelected: group == groupSelected,
                                              isSelecting: controller.addNewPatient.value,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                //*  GROUP DETAILS
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .42,
                  child: AnimatedBuilder(
                      animation: controller.addNewPatient,
                      builder: (context, _) {
                        return ValueListenableBuilder(
                          valueListenable: controller.groupSelected,
                          builder: (context, groupSelected, _) {
                            if (controller.addNewPatient.value) {
                              return AddGrupoFamiliarWidget(groupStore: groupStore);
                            } else if (groupSelected != null) {
                              return GrupoFamiliarWidget(
                                group: groupSelected,
                                membersStore: membersStore,
                                groupStore: groupStore,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
