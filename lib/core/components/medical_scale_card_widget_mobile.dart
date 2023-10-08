import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class MedicalScaleCardWidgetMobile extends StatelessWidget {
  const MedicalScaleCardWidgetMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Escala médica da Semana',
            style: context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.blackColor, fontSize: 14),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(10),
                color: context.colorsApp.dartMedium,
                elevation: 5,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(radius: 26),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  'Dr. Francisco José',
                                  style: context.textStyles.textPoppinsSemiBold
                                      .copyWith(color: context.colorsApp.blackColor)
                                      .copyWith(fontSize: 12),
                                ),
                                Text(
                                  'Clínico Geral',
                                  style: context.textStyles.textPoppinsRegular
                                      .copyWith(color: context.colorsApp.blackColor)
                                      .copyWith(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 250,
                              height: 40,
                              decoration: BoxDecoration(
                                color: context.colorsApp.dartWhite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today, color: context.colorsApp.greyColor2, size: 14),
                                    const SizedBox(width: 30),
                                    Text(
                                      'Quinta, 13 junho',
                                      style: context.textStyles.textPoppinsBold
                                          .copyWith(color: context.colorsApp.greyColor2, fontSize: 8),
                                    ),
                                    const Spacer(),
                                    Icon(Icons.access_alarm, color: context.colorsApp.greyColor2, size: 14),
                                    const SizedBox(width: 30),
                                    Text(
                                      '10:00' ' - ' '11:00',
                                      style: context.textStyles.textPoppinsBold
                                          .copyWith(color: context.colorsApp.greyColor2, fontSize: 8),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}