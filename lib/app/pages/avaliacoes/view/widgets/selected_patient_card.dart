import 'package:cached_network_image/cached_network_image.dart';
import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:flutter/material.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../clinica_icons_icons.dart';
import '../../../../../core/styles/colors_app.dart';

class SelectedPatientCard extends StatefulWidget {
  final PatientModel? patient;
  final Doctor? doctor;
  final VoidCallback? onEdit;

  const SelectedPatientCard({
    Key? key,
    this.patient,
    this.doctor,
    required this.onEdit,
  }) : super(key: key);

  @override
  SelectedPatientCardState createState() => SelectedPatientCardState();
}

class SelectedPatientCardState extends State<SelectedPatientCard> {
  bool get hasPatient => widget.patient != null;
  bool get hasDoctor => widget.doctor != null;
  PatientModel? get patient => widget.patient;
  Doctor? get doctor => widget.doctor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorsApp.dartWhite,
      borderRadius: BorderRadius.circular(10),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 300,
          maxWidth: 400,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: hasPatient ? 20 : 30,
                          backgroundColor: ColorsApp.instance.backgroundCardColor,
                          backgroundImage: hasDoctor ? CachedNetworkImageProvider(doctor!.image) : null,
                          child: hasPatient
                              ? Icon(
                                  ClinicaIcons.account_circle,
                                  color: ColorsApp.instance.blackColor,
                                  size: 20,
                                )
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patient?.name ?? doctor?.name ?? '',
                              style: context.textStyles.textPoppinsMedium.copyWith(
                                fontSize: 18,
                                color: ColorsApp.instance.blackColor,
                              ),
                            ),
                            if (hasDoctor)
                              Text(
                                doctor?.specialization ?? '',
                                style: context.textStyles.textPoppinsRegular.copyWith(
                                  fontSize: 14,
                                  color: ColorsApp.instance.blackColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                 if(widget.onEdit != null)...{
                   const SizedBox(width: 20),
                  IconButton(
                    onPressed: widget.onEdit,
                    splashColor: context.colorsApp.primary,
                    icon: Icon(
                      Icons.edit,
                      size: 20,
                      color: ColorsApp.instance.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                 },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
