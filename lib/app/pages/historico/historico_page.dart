import 'package:clisp/app/pages/historico/widgets/historic_patient_card.dart';
import 'package:clisp/app/pages/historico/widgets/historic_patient_card_list.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/helps/extension/value_notifier_extension.dart';
import 'package:flutter/material.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../core/components/store_builder.dart';
import '../../../di/get_it.dart';
import '../avaliacoes/view/store/avaliations_store.dart';
import '../doctors/view/store/doctor_store.dart';
import '../gerenciar_pacientes/domain/model/patient_model.dart';
import '../gerenciar_pacientes/view/store/manage_patient_store.dart';
import '../gerenciar_pacientes/view/widgets/search_header.dart';

class HistoricoPage extends StatefulWidget {
  static const String routeName = 'historico';
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  late final ManagePatientsStore _managePatientsStore;
  late final GetAvaliationsStore _getAvaliationsStore;
  late final EditAvaliationsStore _editAvaliationsStore;
  late final DoctorStore _doctorStore;

  late final ValueNotifier<PatientModel?> selectedPatient;

  @override
  void initState() {
    super.initState();
    _managePatientsStore = getIt<ManagePatientsStore>();
    _editAvaliationsStore = getIt<EditAvaliationsStore>();
    _doctorStore = getIt<DoctorStore>();
    _getAvaliationsStore = getIt<GetAvaliationsStore>();

    selectedPatient = ValueNotifier(null);
    searchCt = TextEditingController();
    searchPatients = ValueNotifier(null);

    if (!_managePatientsStore.value.isSuccess) {
      _managePatientsStore.getPatients();
    }
    searchCt.addListener(() {
      selectedPatient.value = null;
    });
  }

  @override
  void dispose() {
    _editAvaliationsStore.dispose();
    _doctorStore.dispose();
    _getAvaliationsStore.dispose();
    super.dispose();
  }

  late final TextEditingController searchCt;
  late final ValueNotifier<List<PatientModel>?> searchPatients;

  set addSearchPatients(List<PatientModel> patients) => searchPatients.value = [...patients];

  void resetSearch() {
    searchPatients.value = null;
    searchCt.clear();
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
              'Histórico de consultas',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 40),
            ValueListenableBuilder(
                valueListenable: searchPatients,
                builder: (context, search, _) {
                  return StoreBuilder<List<PatientModel>>(
                    store: _managePatientsStore,
                    validateDefaultStates: true,
                    builder: (context, list, _) {
                      List<PatientModel> patients = search ?? list;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// SECTION 1 - LISTA DE PACIENTES ---------------------
                          Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .1,
                                width: MediaQuery.of(context).size.width * .32,
                                child: SearchHeader(
                                  patients: patients,
                                  controller: searchCt,
                                  findedPatients: (p) => p != null ? addSearchPatients = p : resetSearch(),
                                  isAddPatient: false,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .7,
                                width: MediaQuery.of(context).size.width * .32,
                                child: PhysicalModel(
                                  elevation: 1,
                                  color: context.colorsApp.backgroundCardColor,
                                  borderRadius: BorderRadius.circular(20),
                                  child: ListView.separated(
                                    itemCount: patients.length,
                                    padding: const EdgeInsets.all(8),
                                    separatorBuilder: (_, __) => const Divider(),
                                    itemBuilder: (context, index) {
                                      final patient = patients[index];
                                      return AnimatedBuilder(
                                          animation: selectedPatient,
                                          builder: (context, _) {
                                            return HistoricPatientCard(
                                              onTap: () {
                                                if (selectedPatient.value?.id == patient.id) {
                                                  selectedPatient.value = null;
                                                } else {
                                                  selectedPatient.value = patient;
                                                }
                                              },
                                              isSelected: selectedPatient.value?.id == patient.id,
                                              patient: patient,
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// SECTION 2 - LISTA DE CONSULTAS ---------------------
                          const Spacer(),
                          ValueListenableBuilder(
                            valueListenable: selectedPatient,
                            builder: (context, patient, _) {
                              return selectedPatient.exists
                                  ? HistoricPatientCardList(
                                      store: _getAvaliationsStore,
                                      patient: patient!,
                                    )
                                  : const SizedBox.shrink();
                            },
                          )
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
