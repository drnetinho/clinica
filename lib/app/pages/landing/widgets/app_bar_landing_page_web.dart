import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class AppBarLandingPageWeb extends StatelessWidget {
  const AppBarLandingPageWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double unitHeight = MediaQuery.of(context).size.height * 0.001;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Image.asset('assets/images/clinica_image.png'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clinica Clisp',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.secondaryColorRed, fontSize: 28 * unitHeight),
            ),
            Text(
              'Endereço: Rua 1, 123, Centro, Cidade, UF',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.greyColor, fontSize: 20 * unitHeight),
            ),
            Text(
              'Telefone: (11) 1234-5678',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.greyColor2, fontSize: 20 * unitHeight),
            ),
          ],
        ),
      ],
    );
  }
}
