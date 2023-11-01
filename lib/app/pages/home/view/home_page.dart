import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:clisp/app/pages/avaliacoes/avaliacoes_page.dart';
import 'package:clisp/app/pages/formas_pagamento/formas_de_pagamento_page.dart';
import 'package:clisp/app/pages/grupo_familiar/view/grupo_familiar_page.dart';
import 'package:clisp/app/pages/home/view/widgets/app_bar_widget.dart';
import 'package:clisp/app/pages/home/view/widgets/escala_medica.dart';
import 'package:clisp/app/pages/relatorios/view/relatorios_page.dart';

import '../../../../clinica_icons_icons.dart';
import '../../../../core/components/card_categoria_widget.dart';
import '../../../root/router_controller.dart';
import '../../gerenciar_pacientes/view/gerenciar_pacientes_page.dart';
import '../../historico/historico_page.dart';
import '../../scale/view/edit_medical_scale.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/inicio';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsApp.whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          bottom: 20,
          left: 100,
          right: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const AppBarWidget(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text('Pacientes', style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 22)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      children: [
                        CardCategoriasWidget(
                          width: 290,
                          background: context.colorsApp.dartMedium,
                          icon: ClinicaIcons.user_config,
                          title: 'Gerenciar Paciente',
                          subTitle: 'Adicionar novos pacientes\n e gerenciar os existentes',
                          onTap: () => context.go(subRoute(HomePage.routeName, GerenciarPacientesPage.routeName)),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        CardCategoriasWidget(
                          width: 290,
                          background: context.colorsApp.dartMedium,
                          icon: ClinicaIcons.clock_baseline_history,
                          title: 'Histórico do Paciente',
                          subTitle: 'Acessar histórico de\nconsultas de um paciente.',
                          onTap: () => context.go(subRoute(HomePage.routeName, HistoricoPage.routeName)),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      children: [
                        CardCategoriasWidget(
                          width: 290,
                          background: context.colorsApp.dartMedium,
                          icon: ClinicaIcons.family,
                          title: 'Grupo Familiar',
                          subTitle: 'Ver membros e acessar\ndetalhes do grupo familiar.',
                          onTap: () => context.go(subRoute(HomePage.routeName, GrupoFamiliarPage.routeName)),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        CardCategoriasWidget(
                          width: 290,
                          background: context.colorsApp.dartMedium,
                          icon: ClinicaIcons.notes_medical,
                          title: 'Avaliações do Paciente',
                          subTitle: 'Adicionar avaliações\n(Receitas, solicitações de exames)',
                          onTap: () => context.go(subRoute(HomePage.routeName, AvaliacoesPage.routeName)),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    EscalaMedica(
                      onPressedEdit: () => context.go(
                        subRoute(HomePage.routeName, EditMedicalScale.subRoute),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Pagamentos', style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 22)),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        Column(
                          children: [
                            CardCategoriasWidget(
                              background: context.colorsApp.dartMedium,
                              width: 350,
                              title: 'Dados de Pagamento',
                              subTitle: 'Alterar informações de pagamento\n(Dados bancários, QR Code, etc.)',
                              onTap: () => context.go(subRoute(HomePage.routeName, FormasDePagamentoPage.routeName)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            CardCategoriasWidget(
                              background: context.colorsApp.dartMedium,
                              width: 350,
                              title: 'Relatórios de Faturamento',
                              subTitle: 'Acessar relatórios de faturamento.\n     ',
                              onTap: () => context.go(subRoute(HomePage.routeName, RelatoriosPage.routeName)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
