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
      body: Row(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .9,
            width: MediaQuery.of(context).size.height * .7,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StoreBuilder<List<PatientModel>>(
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
                  const SizedBox(height: 20),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * .7,
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
                                    border: Border.all(color: ColorsApp.instance.greyColor),
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
          ),
          //ficha medica
          SizedBox(
            height: MediaQuery.of(context).size.height * .9,
            width: MediaQuery.of(context).size.height * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 90, 30, 0),
              child: PhysicalModel(
                elevation: 10,
                color: context.colorsApp.backgroundCardColor,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
          ),
        ],
      ),
    );
  }
}
