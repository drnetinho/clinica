import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class PatientCard extends StatelessWidget {
  final PatientModel patient;
  final bool isSelected;

  const PatientCard({
    Key? key,
    required this.patient,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, top: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.person, size: 30, color: ColorsApp.instance.primaryColorGrean),
              const SizedBox(width: 4),
              Text(
                patient.name,
                style: context.textStyles.textPoppinsMedium.copyWith(
                  fontSize: 14,
                  color: isSelected ? ColorsApp.instance.primaryColorGrean : null,
                ),
              ),
              if (kDebugMode) ...{
                const SizedBox(width: 4),
                Text(
                  patient.id,
                  style: context.textStyles.textPoppinsMedium.copyWith(
                    fontSize: 14,
                    color: ColorsApp.instance.primaryColorGrean,
                  ),
                ),
              },
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: isSelected ? ColorsApp.instance.primaryColorGrean : ColorsApp.instance.greyColor,
              ),
            ],
          ),
          Divider(
            color: isSelected ? ColorsApp.instance.primaryColorGrean : ColorsApp.instance.greyColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
