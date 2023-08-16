import 'package:flutter/widgets.dart';
import 'package:netinhoappclinica/app/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Image.asset('assets/images/clinica_image.png'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clinica Clisp',
              style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.secondaryColorRed, fontSize: 16),
            ),
            Text(
              'Endereço: Rua 1, 123, Centro, Cidade, UF',
              style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.greyColor, fontSize: 14),
            ),
            Text(
              'Telefone: (11) 1234-5678',
              style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.greyColor2, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
