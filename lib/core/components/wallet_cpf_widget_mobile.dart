import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import 'input_field.dart';

class WalletCpfWidgetMobile extends StatelessWidget {
  const WalletCpfWidgetMobile({
    super.key,
    required this.cpfControlller,
  });

  final TextEditingController cpfControlller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Área do Paciente',
            style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.blackColor, fontSize: 14),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  'Acessar Carteirinha do Grupo Familiar',
                  style: context.textStyles.textPoppinsSemiBold
                      .copyWith(color: context.colorsApp.blackColor, fontSize: 12),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  'Insira o CPF de  algum participante do seu grupo familiar',
                  style:
                      context.textStyles.textPoppinsRegular.copyWith(color: context.colorsApp.blackColor, fontSize: 10),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.74,
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
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.74,
                  child: ElevatedButton(onPressed: () {}, child: const Text('Acessar')),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset('assets/images/Group.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
