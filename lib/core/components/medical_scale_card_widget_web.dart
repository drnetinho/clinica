import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class MedicalScaleCardWidgetWeb extends StatelessWidget {
  const MedicalScaleCardWidgetWeb({
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
          Text('Escala médica do dia',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.blackColor, fontSize: 32 * unitHeight)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          SizedBox(
            height: 160 * unitHeight,
            width: MediaQuery.of(context).size.width,
            child: PhysicalModel(
              borderRadius: BorderRadius.circular(10),
              color: context.colorsApp.dartMedium,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 40 * unitHeight),
                    const SizedBox(width: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dr. Francisco José',
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(color: context.colorsApp.blackColor)
                              .copyWith(fontSize: 26 * unitHeight),
                        ),
                        Text(
                          'Clínico Geral',
                          style: context.textStyles.textPoppinsRegular
                              .copyWith(color: context.colorsApp.blackColor)
                              .copyWith(fontSize: 22 * unitHeight),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.36,
                      height: 50 * unitHeight,
                      decoration: BoxDecoration(
                        color: context.colorsApp.dartWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today, color: context.colorsApp.greyColor2, size: 40 * unitHeight),
                            const SizedBox(width: 30),
                            Text(
                              'Quinta, 13 junho',
                              style: context.textStyles.textPoppinsBold
                                  .copyWith(color: context.colorsApp.greyColor2, fontSize: 22 * unitHeight),
                            ),
                            const Spacer(),
                            Icon(Icons.access_alarm, color: context.colorsApp.greyColor2, size: 40 * unitHeight),
                            const SizedBox(width: 30),
                            Text(
                              '10:00' ' - ' '11:00',
                              style: context.textStyles.textPoppinsBold
                                  .copyWith(color: context.colorsApp.greyColor2, fontSize: 22 * unitHeight),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
