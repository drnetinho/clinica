import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/ficha_medica_widget.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/new_patient_form_widget.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/patient_card.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/search_header.dart';
import 'package:netinhoappclinica/common/state/app_state.dart';
import 'package:netinhoappclinica/core/components/state_widget.dart';
import 'package:netinhoappclinica/core/helps/extension/value_notifier_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../core/components/store_builder.dart';
import 'controller/gerenciar_pacientes_controller.dart';
import 'store/edit_patient_store.dart';

class GerenciarPacientesPage extends StatefulWidget {
  static const routeName = 'gerenciar_pacientes';
  const GerenciarPacientesPage({super.key});

  @override
  State<GerenciarPacientesPage> createState() => _GerenciarPacientesPageState();
}

class _GerenciarPacientesPageState extends State<GerenciarPacientesPage> {
  // Stores
  late final ManagePatientsStore patientsStore;
  late final EditPatientsStore editPatientsStore;

  // Controllers
  late final GerenciarPacientesController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<GerenciarPacientesController>();
    patientsStore = getIt<ManagePatientsStore>();
    editPatientsStore = getIt<EditPatientsStore>();
    patientsStore.getPatients();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    patientsStore.addListener(
      () {
        if (patientsStore.value is AppStateSuccess) {
          final data = (patientsStore.value as AppStateSuccess).data as List<PatientModel>;

          controller.patientSelected.value = data.first;
        }
      },
    );
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
              'Gerenciar Pacientes',
              style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 36),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //container 01
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.width * .32,
                        child: StoreBuilder<List<PatientModel>>(
                          store: patientsStore,
                          validateDefaultStates: false,
                          builder: (context, patients, child) {
                            return SearchHeader(
                              patients: patients,
                              controller: controller.searchCt,
                              findedPatients: (p) {
                                if (p != null) {
                                  controller.addSearchPatients = p;
                                } else {
                                  controller.resetSearch();
                                }
                              },
                              addPatient: (v) => controller.toogleAddNewPatient = v,
                            );
                          },
                        ),
                      ),
                      PhysicalModel(
                        elevation: 10,
                        color: context.colorsApp.backgroundCardColor,
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .7,
                          width: MediaQuery.of(context).size.width * .32,
                          child: ValueListenableBuilder(
                              valueListenable: controller.searchPatients,
                              builder: (context, search, _) {
                                return StoreBuilder<List<PatientModel>>(
                                  store: patientsStore,
                                  validateEmptyList: true,
                                  builder: (context, value, child) {
                                    List<PatientModel> patients = search ?? value;
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: context.colorsApp.backgroundCardColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: AnimatedBuilder(
                                        animation: Listenable.merge([
                                          controller.patientSelected,
                                          controller.addNewPatient,
                                        ]),
                                        builder: (context, child) {
                                          return ListView.builder(
                                            padding: const EdgeInsets.only(top: 10, left: 22, right: 22, bottom: 10),
                                            shrinkWrap: true,
                                            itemCount: patients.length,
                                            itemBuilder: (context, index) {
                                              final patient = patients[index];

                                              return IgnorePointer(
                                                ignoring: controller.addNewPatient.value,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.patientSelected.value = null;
                                                    controller.patientSelected.value = patient;
                                                  },
                                                  child: PatientCard(
                                                    patient: patient,
                                                    isSelected: patient == controller.patientSelected.value,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                //ficha medica
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .4,
                  child: PhysicalModel(
                    elevation: 10,
                    color: context.colorsApp.backgroundCardColor,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedBuilder(
                        animation: Listenable.merge([controller.patientSelected, controller.addNewPatient]),
                        builder: (contex, child) {
                          if (controller.addNewPatient.value) {
                            return NewPatientFormWidget(
                              manageStore: patientsStore,
                              editStore: editPatientsStore,
                            );
                          } else if (controller.patientSelected.exists) {
                            return FichaMedicaWidget(
                              patient: controller.patientSelected.value!,
                              manageStore: patientsStore,
                              editStore: editPatientsStore,
                            );
                          } else {
                            return const StateInitialWidget();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
