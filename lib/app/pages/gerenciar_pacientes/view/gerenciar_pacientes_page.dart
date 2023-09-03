import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/store/patients_store.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/ficha_medica_widget.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/patient_card.dart';
import 'package:netinhoappclinica/common/state/app_state.dart';
import 'package:netinhoappclinica/core/components/state_widget.dart';
import 'package:netinhoappclinica/core/helps/extension/value_notifier_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../core/components/store_builder.dart';

class GerenciarPacientesPage extends StatefulWidget {
  static const routeName = 'gerenciar_pacientes';
  const GerenciarPacientesPage({super.key});

  @override
  State<GerenciarPacientesPage> createState() => _GerenciarPacientesPageState();
}

class _GerenciarPacientesPageState extends State<GerenciarPacientesPage> {
  late final ManagePatientsStore patientsStore;
  late final EditPatientsStore editPatientsStore;
  late final ValueNotifier<PatientModel?> patientSelected;

  @override
  void initState() {
    super.initState();
    patientsStore = getIt<ManagePatientsStore>();
    editPatientsStore = getIt<EditPatientsStore>();
    patientsStore.getPatients();
    patientSelected = ValueNotifier(null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    patientsStore.addListener(
      () {
        if (patientsStore.value is AppStateSuccess) {
          final data = (patientsStore.value as AppStateSuccess).data as List<PatientModel>;

          // patientSelected.value = data.first;
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
                  Text(
                    'Gerenciar Pacientes',
                    style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 60,
                          child: Card(
                            color: context.colorsApp.backgroundCardColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.search, size: 30, color: ColorsApp.instance.success),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Pesquisar Paciente',
                                            hintStyle: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (patientSelected.exists) {
                                editPatientsStore.addPatient(
                                  patient: patientSelected.value!.copyWith(
                                    age: DateTime.now().toIso8601String(),
                                    name: 'Thiago Fernandes',
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 16, color: ColorsApp.instance.whiteColor),
                                const SizedBox(width: 10),
                                Text('Novo Paciente',
                                    style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * .7,
                      child: StoreBuilder<List<PatientModel>>(
                        store: patientsStore,
                        validateEmptyList: true,
                        builder: (context, value, child) {
                          return Container(
                            decoration: BoxDecoration(
                              color: context.colorsApp.backgroundCardColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: ColorsApp.instance.greyColor),
                            ),
                            child: AnimatedBuilder(
                              animation: patientSelected,
                              builder: (context, child) {
                                return ListView.builder(
                                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22, bottom: 10),
                                  shrinkWrap: true,
                                  itemCount: value.length,
                                  itemBuilder: (context, index) {
                                    final patient = value[index];

                                    return GestureDetector(
                                      onTap: () {
                                        patientSelected.value = null;
                                        patientSelected.value = patient;
                                      },
                                      child: PatientCard(
                                        patient: patient,
                                        isSelected: patient == patientSelected.value,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
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
              child: Card(
                color: context.colorsApp.backgroundCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedBuilder(
                        animation: Listenable.merge([patientSelected]),
                        builder: (contex, child) {
                          if (patientSelected.exists) {
                            return FichaMedicaWidget(
                              patient: patientSelected.value!,
                              manageStore: patientsStore,
                              editStore: editPatientsStore,
                            );
                          } else {
                            return const StateInitialWidget();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
