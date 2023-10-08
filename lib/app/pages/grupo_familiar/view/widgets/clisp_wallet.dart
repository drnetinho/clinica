import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/components/animated_resize.dart';

class ClispWallet extends StatelessWidget {
  final String groupName;
  final List<PatientModel> members;
  const ClispWallet({
    Key? key,
    required this.groupName,
    required this.members,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO Thiago finalizar carteira clisp ( Alinhamento dos pacientes), HELP ARTUR
    return AnimatedResize(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Container(
          width: 500,
          height: 300,
          decoration: BoxDecoration(color: context.colorsApp.greenDark2, borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(36, 36, 36, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.family_restroom, size: 60, color: context.colorsApp.dartWhite),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carteira Clisp',
                          style: context.textStyles.textPoppinsBold
                              .copyWith(fontSize: 24, color: context.colorsApp.dartWhite),
                        ),
                        Text(
                          groupName,
                          style: context.textStyles.textPoppinsBold
                              .copyWith(fontSize: 18, color: context.colorsApp.greenDark),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 100,
                      runSpacing: 20,
                      children: List.generate(
                        members.length,
                        (index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              members[index].name,
                              style: context.textStyles.textPoppinsSemiBold
                                  .copyWith(fontSize: 16, color: context.colorsApp.dartWhite),
                            ),
                            Text(
                              members[index].cpf,
                              style: context.textStyles.textPoppinsSemiBold
                                  .copyWith(fontSize: 12, color: context.colorsApp.greenDark),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
