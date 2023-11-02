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

class HistoricoPage extends StatefulWidget {
  static const String routeName = 'historicopa';
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

    if (!_managePatientsStore.value.isSuccess) {
      _managePatientsStore.getPatients();
    }
  }

  @override
  void dispose() {
    _editAvaliationsStore.dispose();
    _doctorStore.dispose();
    _getAvaliationsStore.dispose();
    super.dispose();
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
            StoreBuilder<List<PatientModel>>(
              store: _managePatientsStore,
              validateDefaultStates: true,
              builder: (context, patients, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// SECTION 1 - LISTA DE PACIENTES ---------------------
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .32,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Busque por nome dou grupo ou do paciente',
                              hintStyle: context.textStyles.textPoppinsRegular.copyWith(fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              icon: Icon(Icons.search, color: context.colorsApp.greyColor2),
                              filled: true,
                              fillColor: context.colorsApp.backgroundCardColor,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .7,
                          width: MediaQuery.of(context).size.width * .32,
                          child: PhysicalModel(
                            elevation: 1,
                            color: context.colorsApp.backgroundCardColor,
                            borderRadius: BorderRadius.circular(20),
                            child: ListView.separated(
                              itemCount: patients.length,
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
            ),
          ],
        ),
      ),
    );
  }
}
