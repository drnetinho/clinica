import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:flutter/material.dart';

import 'package:clisp/app/pages/avaliacoes/domain/model/avaliation.dart';

import '../../../../clinica_icons_icons.dart';

class HistoricAvaliationCard extends StatelessWidget {
  final VoidCallback onDetailPressed;
  final Avaliation avaliation;

  const HistoricAvaliationCard({
    Key? key,
    required this.onDetailPressed,
    required this.avaliation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: context.colorsApp.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(ClinicaIcons.healthicons_doctor, color: context.colorsApp.primary),
                const SizedBox(width: 10),
                Text(
                  'Consulta',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 20),
                ),
              ],
            ),
            Text(
              avaliation.data.toDateTime.formatted,
              style: context.textStyles.textPoppinsRegular.copyWith(
                fontSize: 20,
                color: context.colorsApp.greyColor2,
              ),
            ),
            ElevatedButton(
              onPressed: onDetailPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorsApp.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: context.colorsApp.primary,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Detalhar',
                style: context.textStyles.textPoppinsSemiBold.copyWith(
                  fontSize: 12,
                  color: context.colorsApp.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
