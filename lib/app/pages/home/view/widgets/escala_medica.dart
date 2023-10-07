import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class EscalaMedica extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? background;
  final void Function()? onPressedEdit;
  const EscalaMedica({
    super.key,
    this.width,
    this.height,
    this.background,
    required this.onPressedEdit,
  });

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
      width: width ?? 400,
      height: height ?? getheight(context),
      child: Column(
        children: [
          Text('Informações Gerais',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(fontSize: 28, color: context.colorsApp.transparentColor)),
          const SizedBox(height: 20),
          SizedBox(
            child: PhysicalModel(
              color: ColorsApp.instance.dartMedium,
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. Francisco José',
                              style: context.textStyles.textPoppinsSemiBold
                                  .copyWith(color: context.colorsApp.blackColor)
                                  .copyWith(fontSize: 18),
                            ),
                            Text(
                              'Clínico Geral',
                              style: context.textStyles.textPoppinsRegular
                                  .copyWith(color: context.colorsApp.greyColor2)
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: onPressedEdit,
                          child: Row(
                            children: [
                              const Icon(Icons.edit, size: 14),
                              const SizedBox(width: 5),
                              Text(
                                'Editar',
                                style: context.textStyles.textPoppinsSemiBold
                                    .copyWith(color: context.colorsApp.whiteColor)
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colorsApp.dartWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, color: context.colorsApp.greyColor2, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            'Quinta, 13 junho',
                            style: context.textStyles.textPoppinsSemiBold
                                .copyWith(color: context.colorsApp.greyColor2, fontSize: 14),
                          ),
                          const SizedBox(width: 30),
                          Icon(Icons.access_alarm, color: context.colorsApp.greyColor2, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            '10:00' ' - ' '11:00',
                            style: context.textStyles.textPoppinsSemiBold
                                .copyWith(color: context.colorsApp.greyColor2, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
