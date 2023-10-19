import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class GoLoginAdminMobile extends StatefulWidget {
  const GoLoginAdminMobile({
    super.key,
  });

  @override
  State<GoLoginAdminMobile> createState() => _GoLoginAdminMobileState();
}

class _GoLoginAdminMobileState extends State<GoLoginAdminMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sistema de Gerenciamento\nde cadastros',
                style: context.textStyles.textPoppinsSemiBold.copyWith(
                  color: context.colorsApp.blackColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'Acompanhe os relatórios atualizados,\ngerencie cadastros, monetização e\nmuito mais.',
                style:
                    context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.greyColor, fontSize: 13),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/doctor.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
