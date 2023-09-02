import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class FichaMedicaWidget extends StatelessWidget {
  final PatientModel patient;

  const FichaMedicaWidget({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dados Pessoais',
          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.success),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  patient.name,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                const SizedBox(height: 10),
                Text('Sexo:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  patient.gender,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
            const SizedBox(width: 150),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Idade:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  patient.age,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                const SizedBox(height: 10),
                Text('Contato:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  patient.phone,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(
          'Endereço',
          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.success),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cidade:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  patient.address.city,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                const SizedBox(height: 10),
                Text('Bairro:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  patient.address.neighborhood,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
            const SizedBox(width: 180),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rua:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  patient.address.street,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                const SizedBox(height: 10),
                Text('Número:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  patient.address.number,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doenças Pré-Existentes',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.success),
                ),
                const SizedBox(height: 10),
                ...patient.previousIlnesses.map(
                  (illness) => Text(
                    illness,
                    style:
                        context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 125),
            Column(
              children: [
                Text(
                  'Grupo Familiar',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.success),
                ),
                const SizedBox(height: 10),
                Text(
                  patient.familyGroup,
                  style:
                      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
