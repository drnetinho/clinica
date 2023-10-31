import 'package:flutter/material.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../core/styles/colors_app.dart';

class FichaExameFisicoWidget extends StatelessWidget {
  const FichaExameFisicoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsApp.instance.greyColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildExameField("Pressão Arterial", "mmHg", context),
            _buildExameField("Frequência Cardíaca", "bpm", context),
            _buildExameField("Frequência Respiratória", "rpm", context),
            Row(
              children: [
                _buildExameField("Peso", "kg", context),
                const SizedBox(width: 20),
                _buildExameField("Altura", "cm", context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExameField(String label, String unit, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: ColorsApp.instance.greyColor2),
        ),
        SizedBox(
          width: 46,
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "______",
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
            ),
            textAlign: TextAlign.center,
            strutStyle: const StrutStyle(height: 1.5),
            keyboardType: TextInputType.number,
          ),
        ),
        Text(unit,
            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: ColorsApp.instance.greyColor2)),
      ],
    );
  }
}
