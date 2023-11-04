import 'package:clisp/app/pages/avaliacoes/view/widgets/avaliation_label.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/avaliation_selector_card.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/save_avaliation_button.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/search_patients.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/components/store_builder.dart';
import 'package:clisp/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/exames_solicitados_dialog.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/ficha_exames_fisicos_widget.dart';
import 'package:clisp/core/styles/text_app.dart';
import '../../../../core/styles/colors_app.dart';

class AvaliacoesPage extends StatefulWidget {
  static const String routeName = 'avaliacoes';

  const AvaliacoesPage({super.key});

  @override
  State<AvaliacoesPage> createState() => _AvaliacoesPageState();
}

class _AvaliacoesPageState extends State<AvaliacoesPage> {
  late final ManagePatientsStore _managePatientsStore;

  @override
  void initState() {
    super.initState();
    _managePatientsStore = getIt<ManagePatientsStore>();

    if (!_managePatientsStore.value.isSuccess) {
      _managePatientsStore.getPatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreBuilder<List<PatientModel>>(
          store: _managePatientsStore,
          builder: (context, patients, _) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 20, 30, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Adicionar Avaliação',
                          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
                        ),
                        const SizedBox(height: 50),
                        const AvaliationLabel(title: 'Selecionar Paciente'),
                        const SizedBox(height: 10),
                        AvaliationSelectorCard(
                          title: 'Selecionar um paciente',
                          onTap: () => showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (_) => SearchPatients(
                              patients: patients,
                              selectedPatient: (patient) {
                                if (patient != null) {
                                  
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                        const AvaliationLabel(title: 'Exames Solicitados'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.add, color: context.colorsApp.greyColor2, size: 14),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () => showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (_) => const ExamesSolicitadosDialog(),
                              ),
                              child: const AvaliationLabel(title: 'Selecionar Exames', fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                        const AvaliationLabel(title: 'Exame Físico'),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                              activeColor: ColorsApp.instance.primary,
                              value: 1,
                              groupValue: 1,
                              onChanged: (value) {},
                            ),
                            const AvaliationLabel(title: 'Normal', fontSize: 14),
                            const SizedBox(width: 20),
                            Radio(
                              activeColor: ColorsApp.instance.primary,
                              value: 1,
                              groupValue: 1,
                              onChanged: (value) {},
                            ),
                            const AvaliationLabel(title: 'Alterado', fontSize: 14),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const FichaExameFisicoWidget(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 110, 100, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AvaliationLabel(title: 'Observações'),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.36,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16),
                            maxLines: null,
                            expands: true,
                            textAlign: TextAlign.justify,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              hintStyle: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16),
                              hintText: 'Observações da consulta',
                              hintTextDirection: TextDirection.ltr,
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                        const AvaliationLabel(title: 'Médico Responsável'),
                        const SizedBox(height: 10),
                        AvaliationSelectorCard(
                          title: 'Selecionar um médico',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),
                        SaveAvaliationButton(
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
