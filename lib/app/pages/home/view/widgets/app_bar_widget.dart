import 'package:flutter/widgets.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  double getwidth(BuildContext context) {
    // A largura nao pode ser menor que 600
    if (MediaQuery.of(context).size.width * 0.3 < 800) {
      return 800;
    } else {
      return MediaQuery.of(context).size.width * 0.3;
    }
  }

  double getheight(BuildContext context) {
    // A altura nao pode ser menor que 250
    if (MediaQuery.of(context).size.height * 0.2 < 250) {
      return 250;
    } else {
      return MediaQuery.of(context).size.height * 0.22;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getwidth(context),
      height: getheight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Informações Gerais', style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 28)),
          const SizedBox(height: 20),
          Row(
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
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(color: context.colorsApp.secondaryColorRed, fontSize: 16),
                  ),
                  Text(
                    'Endereço: Rua 1, 123, Centro, Cidade, UF',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(color: context.colorsApp.greyColor, fontSize: 14),
                  ),
                  Text(
                    'Telefone: (11) 1234-5678',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(color: context.colorsApp.greyColor2, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
