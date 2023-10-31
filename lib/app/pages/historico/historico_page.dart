import 'package:flutter/material.dart';
import 'package:clisp/core/components/drop_filter.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../clinica_icons_icons.dart';

class HistoricoPage extends StatefulWidget {
  static const String routeName = 'historicopaciente';
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  List<String> names = [
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
    'Thiago Fernandes',
  ];

  List<DateTime> dates = [
    DateTime.utc(2023, 01, 10),
    DateTime.utc(2023, 02, 10),
    DateTime.utc(2023, 03, 10),
    DateTime.utc(2023, 04, 10),
    DateTime.utc(2023, 05, 10),
    DateTime.utc(2023, 06, 10),
    DateTime.utc(2023, 07, 10),
    DateTime.utc(2023, 08, 10),
    DateTime.utc(2023, 09, 10),
    DateTime.utc(2023, 10, 10),
    DateTime.utc(2023, 11, 10),
    DateTime.utc(2023, 12, 10),
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
              'Histórico de consultas',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .32,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Buscar Pacientes ou Grupos',
                          hintStyle: context.textStyles.textPoppinsRegular.copyWith(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          icon: Icon(Icons.search, color: context.colorsApp.greyColor2),
                          filled: true,
                          fillColor: context.colorsApp.backgroundCardColor,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width * .32,
                      child: PhysicalModel(
                        elevation: 1,
                        color: context.colorsApp.backgroundCardColor,
                        borderRadius: BorderRadius.circular(20),
                        child: ListView.builder(
                          itemCount: names.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      names[index],
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
                                      child: Icon(ClinicaIcons.account_circle, color: context.colorsApp.primary, size: 35),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios, color: context.colorsApp.greyColor2),
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
                    ),
                  ],
                ),

                /// Card de Consultas
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .42,
                  child: Stack(
                    children: [
                      PhysicalModel(
                        elevation: 10,
                        color: context.colorsApp.backgroundCardColor,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(34, 28, 34, 22),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lista de Consultas',
                                    style: context.textStyles.textPoppinsSemiBold
                                        .copyWith(fontSize: 20, color: context.colorsApp.primary),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * .7,
                                  width: MediaQuery.of(context).size.width * .42,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: context.colorsApp.backgroundCardColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ListView.builder(
                                      itemCount: dates.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Container(
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: context.colorsApp.whiteColor,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(ClinicaIcons.healthicons_doctor,
                                                          color: context.colorsApp.primary),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        'Consulta',
                                                        style: context.textStyles.textPoppinsSemiBold
                                                            .copyWith(fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                  // colocar somente a data no formato dd/mm/aaaa, se o mm for 1 digito colocar 0 na frente
                                                  Text(
                                                    '${dates[index].day}/${dates[index].month}/${dates[index].year}',
                                                    style: context.textStyles.textPoppinsRegular
                                                        .copyWith(fontSize: 20, color: context.colorsApp.greyColor2),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: context.colorsApp.whiteColor,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                          side: BorderSide(color: context.colorsApp.primary, width: 2)),
                                                    ),
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Detalhar',
                                                      style: context.textStyles.textPoppinsSemiBold
                                                          .copyWith(fontSize: 12, color: context.colorsApp.primary),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 20,
                        child: DropFilter(
                          selectedValue: (p0) {},
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
