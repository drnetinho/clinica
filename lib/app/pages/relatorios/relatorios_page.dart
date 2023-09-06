import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class RelatoriosPage extends StatefulWidget {
  static const String routeName = 'relatorios';
  const RelatoriosPage({super.key});

  @override
  State<RelatoriosPage> createState() => _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> {
  List<String> gruposFamiliar = [
    'Family 1',
    'Family 2',
    'Family 3',
    'Family 4',
    'Family 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(110, 30, 110, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Relatórios de Fatuamento',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .42,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            color: context.colorsApp.backgroundCardColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Total',
                                        style: context.textStyles.textPoppinsRegular
                                            .copyWith(fontSize: 16, color: context.colorsApp.greyColor2),
                                      ),
                                      const SizedBox(width: 60),
                                      Icon(Icons.family_restroom, color: context.colorsApp.greyColor2, size: 20)
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '140',
                                    style: context.textStyles.textPoppinsBold.copyWith(
                                      fontSize: 20,
                                      color: context.colorsApp.greyColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: context.colorsApp.backgroundCardColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Pagos',
                                        style: context.textStyles.textPoppinsRegular
                                            .copyWith(fontSize: 16, color: context.colorsApp.greyColor2),
                                      ),
                                      const SizedBox(width: 60),
                                      Icon(Icons.monetization_on_outlined,
                                          color: context.colorsApp.greyColor2, size: 20)
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '100/140',
                                    style: context.textStyles.textPoppinsBold.copyWith(
                                      fontSize: 20,
                                      color: context.colorsApp.greyColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: context.colorsApp.backgroundCardColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Pendentes',
                                        style: context.textStyles.textPoppinsRegular
                                            .copyWith(fontSize: 16, color: context.colorsApp.greyColor2),
                                      ),
                                      const SizedBox(width: 60),
                                      Icon(Icons.access_time_sharp, color: context.colorsApp.greyColor2, size: 20)
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '40/140',
                                    style: context.textStyles.textPoppinsBold.copyWith(
                                      fontSize: 20,
                                      color: context.colorsApp.greyColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .1),
                      Card(
                        color: context.colorsApp.backgroundCardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.circle, color: context.colorsApp.greenColor, size: 12),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Pagos',
                                    style: context.textStyles.textPoppinsRegular
                                        .copyWith(fontSize: 22, color: context.colorsApp.greyColor2),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * .16),
                                  Icon(Icons.circle, color: context.colorsApp.yellowColor, size: 12),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Pendentes',
                                    style: context.textStyles.textPoppinsRegular
                                        .copyWith(fontSize: 22, color: context.colorsApp.greyColor2),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    '60.50%',
                                    style: context.textStyles.textPoppinsSemiBold
                                        .copyWith(fontSize: 35, color: context.colorsApp.blackColor),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * .16),
                                  Text(
                                    '39.50%',
                                    style: context.textStyles.textPoppinsSemiBold
                                        .copyWith(fontSize: 35, color: context.colorsApp.blackColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: MediaQuery.of(context).size.height * .07,
                                width: MediaQuery.of(context).size.width * .40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [context.colorsApp.greenColor, context.colorsApp.yellowColor],
                                    stops: const [0.6, 0.4],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    '100 Grupos',
                                    style: context.textStyles.textPoppinsMedium
                                        .copyWith(fontSize: 20, color: context.colorsApp.greyColor2),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * .16),
                                  Text(
                                    '40 Grupos',
                                    style: context.textStyles.textPoppinsMedium
                                        .copyWith(fontSize: 20, color: context.colorsApp.greyColor2),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .28,
                  child: Card(
                    color: context.colorsApp.backgroundCardColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Nome do Grupo',
                              style: context.textStyles.textPoppinsRegular
                                  .copyWith(fontSize: 14, color: context.colorsApp.greyColor2),
                            ),
                            Text(
                              'Mensalidade',
                              style: context.textStyles.textPoppinsRegular
                                  .copyWith(fontSize: 14, color: context.colorsApp.greyColor2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Divider(thickness: 2, color: context.colorsApp.greyColor),
                        const Spacer(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .72,
                          width: MediaQuery.of(context).size.width * .28,
                          child: ListView.builder(
                            itemCount: gruposFamiliar.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      subtitle: Text(
                                        '4 membros',
                                        style: context.textStyles.textPoppinsRegular.copyWith(fontSize: 15),
                                      ),
                                      title: Text(
                                        gruposFamiliar[index],
                                        style: context.textStyles.textPoppinsRegular.copyWith(fontSize: 20),
                                      ),
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: context.colorsApp.whiteColor,
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(color: context.colorsApp.primary, width: 2),
                                        ),
                                        child: Icon(Icons.family_restroom, color: context.colorsApp.primary, size: 20),
                                      ),
                                      trailing: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: context.colorsApp.yellowColor,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          'Pendende',
                                          style: context.textStyles.textPoppinsRegular.copyWith(
                                            fontSize: 14,
                                            color: context.colorsApp.blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * .28,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Divider(thickness: 1, color: context.colorsApp.greyColor),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
