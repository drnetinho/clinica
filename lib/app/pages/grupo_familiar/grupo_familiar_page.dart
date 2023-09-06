import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/widgets/grupo_familiar_widget.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class GrupoFamiliarPage extends StatefulWidget {
  static const String routeName = 'grupo_familiar';
  const GrupoFamiliarPage({super.key});

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarPageState();
}

class _GrupoFamiliarPageState extends State<GrupoFamiliarPage> {
  List<String> grupoFamiliar = [
    'Thiago Fernandes Lopes',
    'Adelmo Artur de Aquino',
    'Maria de Fátima Lopes',
    'Lucas de Freitas Gomes',
    'Maria de Fátima Lopes',
  ];

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
              'Grupo Familiar',
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
                          hintText: 'Buscar Pacientes',
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
                      child: Card(
                        color: context.colorsApp.backgroundCardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 1,
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
                                        color: context.colorsApp.primary,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        'Pendende',
                                        style: context.textStyles.textPoppinsRegular.copyWith(
                                          fontSize: 14,
                                          color: context.colorsApp.whiteColor,
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
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .42,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    child: GrupoFamiliarWidget(grupoFamiliar: grupoFamiliar),
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
