import 'package:flutter/material.dart';

import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../clinica_icons_icons.dart';

class HistoricPatientCard extends StatelessWidget {
  final VoidCallback onTap;
  final PatientModel patient;
  final bool isSelected;
  const HistoricPatientCard({
    Key? key,
    required this.onTap,
    required this.patient,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  patient.name,
                  style: context.textStyles.textPoppinsRegular.copyWith(
                    fontSize: 20,
                    color: isSelected ? context.colorsApp.primary : context.colorsApp.blackColor,
                  ),
                ),
                selected: isSelected,
                selectedColor: context.colorsApp.primary,
                leading: Icon(ClinicaIcons.account_circle, color: context.colorsApp.primary, size: 40),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: isSelected ? context.colorsApp.primary : context.colorsApp.greyColor2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
