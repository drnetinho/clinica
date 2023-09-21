import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/app/pages/avaliacoes/avaliacoes_page.dart';
import 'package:netinhoappclinica/app/pages/formas_pagamento/formas_de_pagamento_page.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/grupo_familiar_page.dart';
import 'package:netinhoappclinica/app/pages/home/view/widgets/app_bar_widget.dart';
import 'package:netinhoappclinica/app/pages/home/view/widgets/escala_medica.dart';
import 'package:netinhoappclinica/app/pages/relatorios/relatorios_page.dart';

import '../../../../core/components/card_categoria_widget.dart';
import '../../../root/router_controller.dart';
import '../../gerenciar_pacientes/view/gerenciar_pacientes_page.dart';
import '../../historico/historico_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
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
        padding: const EdgeInsets.only(top: 30.0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              //Appbar + cards Pacientes
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          icon: Icons.person,
                          title: 'Gerenciar',
                          subTitle: 'Adicionar novos pacientes\n e gerenciar os existentes',
                          onTap: () => context.go(subRoute(HomePage.routeName, GerenciarPacientesPage.routeName)),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        CardCategoriasWidget(
                          width: 290,
                          icon: Icons.person,
                          title: 'Histórico',
                          subTitle: 'Alterar informações de pagamento\n(Dados bancários, QR Code, etc.)',
                          onTap: () => context.go(subRoute(HomePage.routeName, HistoricoPage.routeName)),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      children: [
                        CardCategoriasWidget(
                          width: 290,
                          icon: Icons.person,
                          title: 'Grupo Familiar',
                          subTitle: 'Ver membros e acessar\ndetalhes do grupo familiar.',
                          onTap: () => context.go(subRoute(HomePage.routeName, GrupoFamiliarPage.routeName)),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        CardCategoriasWidget(
                          width: 290,
                          icon: Icons.person,
                          title: 'Avaliações',
                          subTitle: 'Adicionar avaliações\n(Receitas, solicitações de exames)',
                          onTap: () => context.go(subRoute(HomePage.routeName, AvaliacoesPage.routeName)),
                        ),
                      ],
                    ),
                  ],
                ),

                //Escala Medica + cards Pagamentos
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const EscalaMedica(),
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
                              width: 400,
                              icon: Icons.person,
                              title: 'Formas de Pagamento',
                              subTitle: 'Alterar informações de pagamento\n(Dados bancários, QR Code, etc.)',
                              onTap: () => context.go(subRoute(HomePage.routeName, FormasDePagamentoPage.routeName)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            CardCategoriasWidget(
                              background: context.colorsApp.dartMedium,
                              width: 400,
                              icon: Icons.person,
                              title: 'Relatórios',
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

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:netinhoappclinica/core/styles/colors_app.dart';
// import 'package:netinhoappclinica/core/styles/text_app.dart';
// import 'package:netinhoappclinica/app/pages/avaliacoes/avaliacoes_page.dart';
// import 'package:netinhoappclinica/app/pages/formas_pagamento/formas_de_pagamento_page.dart';
// import 'package:netinhoappclinica/app/pages/grupo_familiar/view/grupo_familiar_page.dart';
// import 'package:netinhoappclinica/app/pages/home/view/widgets/app_bar_widget.dart';
// import 'package:netinhoappclinica/app/pages/home/view/widgets/escala_medica.dart';
// import 'package:netinhoappclinica/app/pages/relatorios/relatorios_page.dart';

// import '../../../../core/components/card_categoria_widget.dart';
// import '../../../root/router_controller.dart';
// import '../../gerenciar_pacientes/view/gerenciar_pacientes_page.dart';
// import '../../historico/historico_page.dart';

// class HomePage extends StatefulWidget {
//   static const String routeName = '/home';
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colorsApp.whiteColor,
//       body: Padding(
//         padding: const EdgeInsets.only(top: 40.0, left: 80, right: 80),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Informações Gerais', style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 28)),
//             Row(
//               children: [],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const AppBarWidget(),
//                 const EscalaMedica(),
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.01),
//               ],
//             ),
//             const SizedBox(height: 40),
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
//                           child:
//                               Text('Pacientes', style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 22)),
//                         ),
//                         Row(
//                           children: [
//                             CardCategoriasWidget(
//                               width: 290,
//                               icon: Icons.person,
//                               title: 'Gerenciar',
//                               subTitle: 'Adicionar novos pacientes\n e gerenciar os existentes',
//                               onTap: () => context.go(subRoute(HomePage.routeName, GerenciarPacientesPage.routeName)),
//                             ),
//                             SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//                             CardCategoriasWidget(
//                               width: 290,
//                               icon: Icons.person,
//                               title: 'Histórico',
//                               subTitle: 'Alterar informações de pagamento\n(Dados bancários, QR Code, etc.)',
//                               onTap: () => context.go(subRoute(HomePage.routeName, HistoricoPage.routeName)),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         CardCategoriasWidget(
//                           width: 290,
//                           icon: Icons.person,
//                           title: 'Grupo Familiar',
//                           subTitle: 'Ver membros e acessar\ndetalhes do grupo familiar.',
//                           onTap: () => context.go(subRoute(HomePage.routeName, GrupoFamiliarPage.routeName)),
//                         ),
//                         SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//                         CardCategoriasWidget(
//                           width: 290,
//                           icon: Icons.person,
//                           title: 'Avaliações',
//                           subTitle: 'Adicionar avaliações\n(Receitas, solicitações de exames)',
//                           onTap: () => context.go(subRoute(HomePage.routeName, AvaliacoesPage.routeName)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.03),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
//                       child: Text('Pagamentos', style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 22)),
//                     ),
//                     Column(
//                       children: [
//                         CardCategoriasWidget(
//                           width: 400,
//                           icon: Icons.person,
//                           title: 'Formas de Pagamento',
//                           subTitle: 'Alterar informações de pagamento\n(Dados bancários, QR Code, etc.)',
//                           onTap: () => context.go(subRoute(HomePage.routeName, FormasDePagamentoPage.routeName)),
//                         ),
//                         CardCategoriasWidget(
//                           width: 400,
//                           icon: Icons.person,
//                           title: 'Relatórios',
//                           subTitle: 'Acessar relatórios de faturamento.\n     ',
//                           onTap: () => context.go(subRoute(HomePage.routeName, RelatoriosPage.routeName)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
