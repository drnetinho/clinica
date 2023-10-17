import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../core/helps/padding.dart';
import '../../../../core/helps/spacing.dart';

class ExamesSolicitadosDialog extends StatefulWidget {
  const ExamesSolicitadosDialog({super.key});

  @override
  State<ExamesSolicitadosDialog> createState() => _ExamesSolicitadosDialogState();
}

class _ExamesSolicitadosDialogState extends State<ExamesSolicitadosDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: Padd.sh(Spacing.x),
        height: MediaQuery.of(context).size.height * .8,
        width: MediaQuery.of(context).size.width * .4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                'Exames Solicitados',
                style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 30, color: context.colorsApp.primary),
              ),
              const SizedBox(height: Spacing.x),
              //item do listview
              Row(
                children: [
                  Checkbox(
                    activeColor: context.colorsApp.primary,
                    value: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(width: Spacing.m),
                  Text(
                    'Exame 1',
                    style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 20),
                  ),
                ],
              ),
              // const SizedBox(height: Spacing.x),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorsApp.dartWhite,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.close, color: context.colorsApp.blackColor, size: 16),
                        const SizedBox(width: Spacing.s),
                        Text(
                          'Cancelar',
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(fontSize: 12, color: context.colorsApp.softBlack),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Spacing.x),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.check, color: context.colorsApp.whiteColor, size: 16),
                        const SizedBox(width: Spacing.s),
                        Text(
                          'Confirmar',
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(fontSize: 12, color: context.colorsApp.whiteColor),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
