import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class GoLoginAdminMobile extends StatelessWidget {
  const GoLoginAdminMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Sistema de Gerenciamento\nde cadastros',
                  style: context.textStyles.textPoppinsSemiBold
                      .copyWith(color: context.colorsApp.blackColor, fontSize: 14),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                'Acompanhe os relatórios atualizados,\ngerencie cadastros, monetização e\nmuito mais.',
                style:
                    context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.greyColor, fontSize: 10),
              ),
              const SizedBox(height: 60),
              //TODO: LOGIN BLOCKED FOR MOBILE
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: context.colorsApp.whiteColor,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //         side: BorderSide(color: ColorsApp.instance.success)),
              //   ),
              //   onPressed: () {
              //     context.go(SignPage.routeName);
              //   },
              //   child: Text('Entrar',
              //       style: context.textStyles.textPoppinsSemiBold
              //           .copyWith(color: ColorsApp.instance.success, fontSize: 12)),
              // ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset('assets/images/doctor.png'),
          ),
        ],
      ),
    );
  }
}
