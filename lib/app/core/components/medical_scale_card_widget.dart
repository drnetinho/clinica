import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';

class MedicalScaleCardWidget extends StatelessWidget {
  const MedicalScaleCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double unitHeight = MediaQuery.of(context).size.height * 0.001;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Escala médica da Semana',
              style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.blackColor, fontSize: 50 * unitHeight)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 80 * unitHeight),
                  const SizedBox(width: 60),
                  Column(
                    children: [
                      Text(
                        'Nome',
                        style: context.textStyles.textPoppinsBold.copyWith(color: context.colorsApp.blackColor).copyWith(fontSize: 28 * unitHeight),
                      ),
                      Text(
                        'Especialidade',
                        style: context.textStyles.textPoppinsBold.copyWith(color: context.colorsApp.blackColor).copyWith(fontSize: 24 * unitHeight),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: context.colorsApp.greyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, color: context.colorsApp.greyColor2, size: 40 * unitHeight),
                        const SizedBox(width: 10),
                        Text(
                          'Quinta, 13 junho',
                          style: context.textStyles.textPoppinsBold.copyWith(color: context.colorsApp.greyColor2, fontSize: 22 * unitHeight),
                        ),
                        const SizedBox(width: 30),
                        Icon(Icons.access_alarm, color: context.colorsApp.greyColor2, size: 40 * unitHeight),
                        const SizedBox(width: 10),
                        Text(
                          '10:00' ' - ' + '11:00',
                          style: context.textStyles.textPoppinsBold.copyWith(color: context.colorsApp.greyColor2, fontSize: 22 * unitHeight),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
