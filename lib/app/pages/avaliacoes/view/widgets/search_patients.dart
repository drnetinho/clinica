import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/grupo_familiar/view/widgets/search_group_patients.dart';
import 'package:clisp/core/helps/extension/value_notifier_extension.dart';
import 'package:clisp/core/helps/padding.dart';
import 'package:clisp/core/helps/spacing.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../clinica_icons_icons.dart';

class SearchPatients extends StatefulWidget {
  final List<PatientModel> patients;
  final Function(PatientModel?) selectedPatient;

  const SearchPatients({
    Key? key,
    required this.patients,
    required this.selectedPatient,
  }) : super(key: key);

  @override
  State<SearchPatients> createState() => _SearchPatientsState();
}

class _SearchPatientsState extends State<SearchPatients> {
  late final ValueNotifier<PatientModel?> selectedPatient;
  late final ValueNotifier<List<PatientModel>> findedPatients;

  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    findedPatients = ValueNotifier([]);
    selectedPatient = ValueNotifier(null);

    controller = TextEditingController();
  }

  @override
  void dispose() {
    selectedPatient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            SearchGroupPatients(
              controller: controller,
              width: MediaQuery.of(context).size.width * .2,
              patients: widget.patients,
              autoFocus: true,
              searchByGroup: false,
              findedPatients: (p) => p != null ? findedPatients.value = p : findedPatients.value = [],
            ),
            Spacing.xm.verticalGap,
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .35,
                child: ValueListenableBuilder(
                  valueListenable: findedPatients,
                  builder: (context, search, _) {
                    List<PatientModel> patients = search.isNotEmpty ? search : widget.patients;
                    return ListView.builder(
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        final patient = patients[index];

                        return AnimatedBuilder(
                          animation: selectedPatient,
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
                                        value: patient.id,
                                        groupValue: selectedPatient.value?.id,
                                        onChanged: (value) {
                                          if (selectedPatient.value != patient) {
                                            selectedPatient.value = patient;
                                          } else {
                                            selectedPatient.value = null;
                                          }
                                        },
                                      ),
                                      const SizedBox(width: 6),
                                      Icon(ClinicaIcons.profile, size: 40, color: context.colorsApp.primary),
                                    ],
                                  ),
                                ),
                              ),
                              selectedTileColor: context.colorsApp.greenColor.withOpacity(.2),
                              selectedColor: context.colorsApp.blackColor,
                              onTap: () {
                                if (selectedPatient.value != patient) {
                                  selectedPatient.value = patient;
                                } else {
                                  selectedPatient.value = null;
                                }
                              },
                              selected: selectedPatient.exists && selectedPatient.value == patient,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Spacing.xm.verticalGap,
            Container(
              alignment: Alignment.bottomRight,
              padding: Padd.all(Spacing.m),
              child: AnimatedBuilder(
                animation: selectedPatient,
                builder: (context, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: context.colorsApp.dartWhite),
                        onPressed: () {
                          context.pop();
                          controller.clear();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.close, color: context.colorsApp.greenColor2),
                            const SizedBox(height: 10),
                            Text(
                              'Cancelar',
                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                color: context.colorsApp.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacing.m.horizotalGap,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorsApp.primary,
                        ),
                        onPressed: selectedPatient.value != null
                            ? () {
                                widget.selectedPatient.call(selectedPatient.value);
                                context.pop();
                              }
                            : null,
                        child: Row(
                          children: [
                            Icon(Icons.check, color: context.colorsApp.whiteColor),
                            const SizedBox(height: 10),
                            Text(
                              'Confirmar',
                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                color: context.colorsApp.whiteColor,
                              ),
                            ),
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
  }
}
