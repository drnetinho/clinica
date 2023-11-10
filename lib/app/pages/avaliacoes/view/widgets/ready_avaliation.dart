import 'package:flutter/material.dart';

import 'package:clisp/app/pages/avaliacoes/domain/model/avaliation.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/avaliation_label.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/physical_avaliation.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/select_exame_section.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/selected_patient_card.dart';
import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/components/app_form_field.dart';
import 'package:clisp/core/components/snackbar.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../controller/new_avaliation_controller.dart';

class ReadyAvaliation extends StatefulWidget {
  final Avaliation avaliation;
  final Doctor doctor;
  final PatientModel patient;
  final NewAvaliationController controller;

  const ReadyAvaliation({
    Key? key,
    required this.avaliation,
    required this.doctor,
    required this.patient,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReadyAvaliation> createState() => _ReadyAvaliationState();
}

class _ReadyAvaliationState extends State<ReadyAvaliation> with SnackBarMixin {
  @override
  void initState() {
    super.initState();
    widget.controller.setupFields(
      avaliation: widget.avaliation,
      doctor: widget.doctor,
      patient: widget.patient,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    const AvaliationLabel(title: 'Paciente'),
                    const SizedBox(height: 10),
                    SelectedPatientCard(
                      patient: widget.patient,
                      onEdit: null,
                    ),
                    const SizedBox(height: 40),
                    const AvaliationLabel(title: 'Exame Físico'),
                    const SizedBox(height: 10),
                    IgnorePointer(
                      child: PhysicalAvaliation(
                        controller: widget.controller,
                        isReadyMode: true,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const AvaliationLabel(title: 'Exames Solicitados'),
                    const SizedBox(height: 10),
                    IgnorePointer(
                      child: SelectExameSection(
                        controller: widget.controller,
                        store: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SECTION 2 ----------------------------------------
            IgnorePointer(
              child: Expanded(
                flex: 1,
                child: Padding(
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
                          hint: widget.controller.obsCtrl.text.isEmpty
                              ? 'Nenhuma observação'
                              : widget.controller.obsCtrl.text,
                          controller: widget.controller.obsCtrl,
                          readOnly: true,
                          isValid: true,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      const AvaliationLabel(title: 'Médico Responsável'),
                      const SizedBox(height: 10),
                      SelectedPatientCard(
                        doctor: widget.doctor,
                        onEdit: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
