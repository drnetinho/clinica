import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class AppBarLandingPageMobile extends StatelessWidget {
  const AppBarLandingPageMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Image.asset('assets/images/clinica_image.png'),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clinica Clisp',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.secondaryColorRed, fontSize: 14),
            ),
            Text(
              'Endereço: Rua 1, 123, Centro, Cidade, UF',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.greyColor, fontSize: 10),
            ),
            Text(
              'Telefone: (11) 1234-5678',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.greyColor2, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}