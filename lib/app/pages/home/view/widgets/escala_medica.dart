import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class EscalaMedica extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? background;
  const EscalaMedica({
    super.key,
    this.width,
    this.height,
    this.background,
  });

  double getwidth(BuildContext context) {
    // A largura nao pode ser menor que 400
    if (MediaQuery.of(context).size.width * 0.4 < 400) {
      return 600;
    } else {
      return MediaQuery.of(context).size.width * 0.3;
    }
  }

  double getheight(BuildContext context) {
    // A altura nao pode ser menor que 200
    if (MediaQuery.of(context).size.height * 0.2 < 250) {
      return 250;
    } else {
      return MediaQuery.of(context).size.height * 0.22;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? getwidth(context),
      height: height ?? getheight(context),
      child: Column(
        children: [
          Text('Informações Gerais',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(fontSize: 28, color: context.colorsApp.transparentColor)),
          const SizedBox(height: 20),
          SizedBox(
            child: PhysicalModel(
              color: ColorsApp.instance.backgroundCardColor,
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
                        const SizedBox(width: 50),
                        Column(
                          children: [
                            Text(
                              'Nome',
                              style: context.textStyles.textPoppinsBold
                                  .copyWith(color: context.colorsApp.blackColor)
                                  .copyWith(fontSize: 12),
                            ),
                            Text(
                              'Especialidade',
                              style: context.textStyles.textPoppinsBold
                                  .copyWith(color: context.colorsApp.greyColor2)
                                  .copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(width: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(children: [Icon(Icons.edit), Text('Editar')]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colorsApp.bottonBarColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
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
