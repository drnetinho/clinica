import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';
import 'input_field.dart';


class ConsultFileWidget extends StatelessWidget {
  const ConsultFileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cpfControlller = TextEditingController();
    double unitHeight = MediaQuery.of(context).size.height * 0.001;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Área do Paciente',
              style: context.textStyles.textPoppinsSemiBold.copyWith(
                color: context.colorsApp.blackColor,
                fontSize: 50 * unitHeight,
              ),
            ),
            Text(
              'Acessar Carteirinha do\nGrupo Familiar',
              style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.blackColor, fontSize: 32 * unitHeight),
            ),
            const SizedBox(height: 60),
            Text(
              'Insira o CPF de  algum participante do seu\ngrupo familiar',
              style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.blackColor, fontSize: 22 * unitHeight),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              child: InputField(
                controller: cpfControlller,
                maskCpf: true,
                labelTextBorder: 'CPF',
                label: '000.000.000-00',
                maxLength: 14,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              child: ElevatedButton(onPressed: () {}, child: const Text('Acessar')),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Image.asset('assets/images/Group.png'),
        )
      ],
    );
  }
}
