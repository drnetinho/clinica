import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';

class GoLoginAdmin extends StatelessWidget {
  const GoLoginAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double unitHeight = MediaQuery.of(context).size.height * 0.001;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Sistema de Gerenciamento\nde cadastros',
                style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.blackColor, fontSize: 50 * unitHeight),
              ),
            ),
            Text(
              'Acompanhe os relatórios atualizados, gerencie\ncadastros, monetização e muito mais.',
              style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.greyColor, fontSize: 24 * unitHeight),
            ),
            const SizedBox(height: 60),
            ElevatedButton(onPressed: () {}, child: const Text('Entrar'))
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Image.asset('assets/images/doctor.png'),
        )
      ],
    );
  }
}
