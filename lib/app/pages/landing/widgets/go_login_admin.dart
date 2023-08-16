import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/app/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';
import 'package:netinhoappclinica/app/pages/sign/sign_page.dart';

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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorsApp.whiteColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: ColorsApp.instance.primaryColorGrean)),
                ),
                onPressed: () {
                  context.go(SignPage.routeName);
                },
                child: Text('Entrar',
                    style: context.textStyles.textPoppinsSemiBold.copyWith(color: ColorsApp.instance.primaryColorGrean, fontSize: 24 * unitHeight))),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Image.asset('assets/images/doctor.png'),
          ),
        ),
      ],
    );
  }
}
