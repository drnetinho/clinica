import 'package:flutter/material.dart';

import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

class PercentInfoText extends StatelessWidget {
  final String pendingPercent;
  final String receivePercent;
  const PercentInfoText({
    Key? key,
    required this.pendingPercent,
    required this.receivePercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(Icons.circle, color: context.colorsApp.greenColor, size: 12),
            const SizedBox(width: 10),
            Text(
              'Pagos',
              style: context.textStyles.textPoppinsRegular.copyWith(fontSize: 22, color: context.colorsApp.greyColor2),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * .16),
            Icon(Icons.circle, color: context.colorsApp.yellowColor, size: 12),
            const SizedBox(width: 10),
            Text(
              'Pendentes',
              style: context.textStyles.textPoppinsRegular.copyWith(fontSize: 22, color: context.colorsApp.greyColor2),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              receivePercent,
              style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 35, color: context.colorsApp.blackColor),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * .16),
            Text(
              pendingPercent,
              style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 35, color: context.colorsApp.blackColor),
            ),
          ],
        ),
      ],
    );
  }
}
