import 'package:flutter/material.dart';

import 'package:clisp/app/pages/avaliacoes/view/store/avaliations_store.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/avaliation_label.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/avaliation_selector_card.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/physical_avaliation.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/save_avaliation_button.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/search_patients.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/select_exame_section.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/selected_patient_card.dart';
import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/app/pages/doctors/view/store/doctor_store.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/components/app_form_field.dart';
import 'package:clisp/core/components/app_loader.dart';
import 'package:clisp/core/components/snackbar.dart';
import 'package:clisp/core/components/store_builder.dart';
import 'package:clisp/core/helps/extension/value_notifier_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:clisp/di/get_it.dart';

import '../../scale/view/widgets/doctor_selector_dialog.dart';
import 'controller/new_avaliation_controller.dart';

class AvaliacoesPage extends StatefulWidget {
  static const String routeName = 'avaliacoes';

  const AvaliacoesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AvaliacoesPage> createState() => _AvaliacoesPageState();
}

class _AvaliacoesPageState extends State<AvaliacoesPage> with SnackBarMixin {
  late final ManagePatientsStore _managePatientsStore;
  late final GetAvaliationsStore _getAvaliationsStore;
  late final EditAvaliationsStore _editAvaliationsStore;
  late final DoctorStore _doctorStore;

  late final NewAvaliationController controller;

  @override
  void initState() {
    super.initState();
    _managePatientsStore = getIt<ManagePatientsStore>();
    controller = getIt<NewAvaliationController>();
    _editAvaliationsStore = getIt<EditAvaliationsStore>();
    _doctorStore = getIt<DoctorStore>();
    _getAvaliationsStore = getIt<GetAvaliationsStore>();

    _doctorStore.getDoctors();

    if (!_managePatientsStore.value.isSuccess) {
      _managePatientsStore.getPatients();
    }

    _editAvaliationsStore.addListener(() {
      if (_editAvaliationsStore.value.isSuccess) {
        showSuccess(context: context, text: 'Avaliação adicionada com sucesso');
        controller.resetAllFields();
      }

      if (_editAvaliationsStore.value.isError) {
        showError(context: context, text: _editAvaliationsStore.value.error.message);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _getAvaliationsStore.dispose();
    _editAvaliationsStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 40),
            child: Text(
              'Adicionar Avaliação',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          ValueListenableBuilder(
            valueListenable: _editAvaliationsStore,
            builder: (contex, state, _) {
              if (state.isLoading) {
                return Center(
                  child: AppLoader(
                    color: contex.colorsApp.blackColor,
                  ),
                );
              }
              return StoreBuilder<List<Doctor>>(
                store: _doctorStore,
                validateDefaultStates: true,
                builder: (context, doctors, _) {
                  return StoreBuilder<List<PatientModel>>(
                    store: _managePatientsStore,
                    validateDefaultStates: true,
                    builder: (context, patients, _) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SECTION 1 ----------------------------------------
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 40, 30, 50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const AvaliationLabel(title: 'Selecionar Paciente'),
                                      const SizedBox(height: 10),
                                      AnimatedBuilder(
                                        animation: controller.patient,
                                        builder: (context, _) {
                                          if (controller.patient.exists) {
                                            return SelectedPatientCard(
                                              patient: controller.patient.value!,
                                              onEdit: () => showPatientSelector(patients),
                                            );
                                          }
                                          return AvaliationSelectorCard(
                                            title: 'Selecionar um paciente',
                                            onTap: () => showPatientSelector(patients),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 40),
                                      const AvaliationLabel(title: 'Exame Físico'),
                                      const SizedBox(height: 10),
                                      PhysicalAvaliation(
                                        controller: controller,
                                      ),
                                      const SizedBox(height: 40),
                                      const AvaliationLabel(title: 'Exames Solicitados'),
                                      const SizedBox(height: 10),
                                      SelectExameSection(
                                        controller: controller,
                                        store: _getAvaliationsStore,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SECTION 2 ----------------------------------------
                              Expanded(
                                flex: 1,
                                child: ValueListenableBuilder(
                                  valueListenable: controller.form,
                                  builder: (context, form, _) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 40, 100, 50),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const AvaliationLabel(title: 'Observações'),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.4,
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            child: AppFormField(
                                              textStyle: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16),
                                              maxLines: 12,
                                              hint: 'Observações da consulta',
                                              controller: controller.obsCtrl,
                                              isValid: form.obs.isValid,
                                              validator: (_) => form.obs.error?.exists,
                                              errorText: form.obs.displayError?.message,
                                            ),
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                                          const AvaliationLabel(title: 'Médico Responsável'),
                                          const SizedBox(height: 10),
                                          AnimatedBuilder(
                                            animation: Listenable.merge(
                                              [controller.doctor, controller.isValid],
                                            ),
                                            builder: (context, _) {
                                              if (controller.doctor.exists) {
                                                return SelectedPatientCard(
                                                  doctor: controller.doctor.value!,
                                                  onEdit: () => showDoctorSelector(doctors),
                                                );
                                              }
                                              return AvaliationSelectorCard(
                                                title: 'Selecionar um médico',
                                                onTap: () => showDoctorSelector(doctors),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          SaveAvaliationButton(
                                            onPressed: () {
                                              controller.isValidForm
                                                  ? _editAvaliationsStore.createAvaliation(controller.avaliation)
                                                  : showFormWarning();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      )),
    );
  }

  void showFormWarning() => showWarning(
        context: context,
        text: 'Você deve selecionar um paciente e um médico para continuar.',
      );

  void showDoctorSelector(List<Doctor> doctors) => showDialog(
        context: context,
        builder: (context) => DoctorSelectorDialog(
          doctors: doctors,
          scaleStore: null,
          onSelectDoctor: (doctor) => controller.doctor.value = doctor,
        ),
      );

  void showPatientSelector(List<PatientModel> patients) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (_) => SearchPatients(
        patients: patients,
        selectedPatient: (patient) {
          if (patient != null) {
            controller.patient.value = patient;
          }
        },
      ),
    );
  }
}
