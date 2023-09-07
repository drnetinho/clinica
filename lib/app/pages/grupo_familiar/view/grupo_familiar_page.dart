import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/store/group_members_store.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/store/grupo_familiar_store.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/family_group_tile.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/grupo_familiar_widget.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/search_patients_dialog.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/search_group_patients.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../core/components/store_builder.dart';
import 'controller/grupo_familiar_controller.dart';

class GrupoFamiliarPage extends StatefulWidget {
  static const String routeName = 'grupo_familiar';
  const GrupoFamiliarPage({super.key});

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarPageState();
}

class _GrupoFamiliarPageState extends State<GrupoFamiliarPage> {
  late final GrupoFamiliarStore groupStore;
  late final GrupMembersStore membersStore;
  late final GrupoFamiliarController controller;

  @override
  void initState() {
    super.initState();
    groupStore = getIt<GrupoFamiliarStore>();
    membersStore = getIt<GrupMembersStore>();
    controller = getIt<GrupoFamiliarController>();
    groupStore.getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(110, 30, 110, 10),
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
                    SearchGroupPatients(
                      controller: controller.searchCt,
                      patients: const [],
                      onTap: () => showDialog(
                        context: context,
                        builder: (c) => SearchPatientsDialog(
                          controller: controller,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width * .32,
                      child: Card(
                        color: context.colorsApp.backgroundCardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 1,
                        child: StoreBuilder<List<FamilyGroupModel>>(
                          store: groupStore,
                          builder: (context, groups, child) {
                            return ValueListenableBuilder(
                              valueListenable: controller.groupSelected,
                              builder: (context, groupSelected, _) {
                                return ListView.builder(
                                  itemCount: groups.length,
                                  itemBuilder: (context, index) {
                                    final group = groups[index];
                                    return InkWell(
                                      onTap: () => controller.groupSelected.value = group,
                                      child: FamilyGroupTile(
                                        group: group,
                                        isSelected: group == groupSelected,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .42,
                  child: ValueListenableBuilder(
                    valueListenable: controller.groupSelected,
                    builder: (context, groupSelected, _) {
                      if (groupSelected != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                          child: GrupoFamiliarWidget(
                            group: groupSelected,
                            store: membersStore,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
