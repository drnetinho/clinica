import 'package:flutter/material.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/helps/spacing.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import '../../../../../core/components/animated_resize.dart';

class ClispWallet extends StatelessWidget {
  final String groupName;
  final List<PatientModel> members;
  const ClispWallet({
    Key? key,
    required this.groupName,
    required this.members,
  }) : super(key: key);

  String getNameAndSurname(String name) {
    final names = name.split(' ');
    return '${names[0]} ${names[names.length - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedResize(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 500,
          height: 300,
          decoration: BoxDecoration(
            color: context.colorsApp.greenDark2,
            borderRadius: BorderRadius.circular(12),
            gradient: context.colorsApp.greenGradient,
          ),
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
                    Icon(Icons.family_restroom, size: 50, color: context.colorsApp.dartWhite),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carteira Clisp',
                          style: context.textStyles.textPoppinsBold
                              .copyWith(fontSize: 22, color: context.colorsApp.dartWhite),
                        ),
                        Text(
                          groupName,
                          style: context.textStyles.textPoppinsBold
                              .copyWith(fontSize: 16, color: context.colorsApp.greenDark),
                        ),
                      ],
                    )
                  ],
                ),
                Spacing.xs.verticalGap,
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        itemCount: members.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 0.5,
                          childAspectRatio: 16 / 5,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                getNameAndSurname(members[index].name),
                                style: context.textStyles.textPoppinsSemiBold
                                    .copyWith(fontSize: 14, color: context.colorsApp.dartWhite),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'CPF: ${members[index].cpf}',
                                style: context.textStyles.textPoppinsSemiBold
                                    .copyWith(fontSize: 12, color: context.colorsApp.greenDark),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
