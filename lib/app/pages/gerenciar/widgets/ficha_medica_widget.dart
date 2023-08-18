import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';

class FichaMedicaWidget extends StatelessWidget {
  const FichaMedicaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dados Pessoais',
          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.primaryColorGrean),
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
                  'Thiago Fernandes Lopes',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                const SizedBox(height: 10),
                Text('Sexo:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  'Masculino',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
            const SizedBox(width: 150),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Idade:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  '23',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                const SizedBox(height: 10),
                Text('Contato:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  '(11) 9 9999-9999',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(
          'Endereço',
          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.primaryColorGrean),
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
                  'Pau dos Ferros - RN',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                const SizedBox(height: 10),
                Text('Bairro:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  'Centro',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
            const SizedBox(width: 180),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rua:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  'Rua João da Silva',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                const SizedBox(height: 10),
                Text('Número:', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                Text(
                  '9',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
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
              children: [
                Text(
                  'Doenças Pré-Existentes',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.primaryColorGrean),
                ),
                const SizedBox(height: 10),
                Text(
                  '* Diabetes, Hipertensão',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
                Text(
                  '* Diabetes, Hipertensão',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
            const SizedBox(width: 125),
            Column(
              children: [
                Text(
                  'Grupo Familiar',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.primaryColorGrean),
                ),
                const SizedBox(height: 10),
                Text(
                  'Botao ver grupo',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
