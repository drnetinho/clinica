import 'package:clisp/app/pages/avaliacoes/view/ready_avaliation_page.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/ready_avaliation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clisp/app/pages/home/view/home_page.dart';
import 'package:clisp/app/root/root_navigator.dart';
import 'package:clisp/di/get_it.dart';

import '../../common/services/auth/auth_service.dart';
import '../pages/avaliacoes/domain/model/avaliation.dart';
import '../pages/avaliacoes/view/avaliacoes_page.dart';
import '../pages/doctors/view/doctors_page.dart';
import '../pages/formas_pagamento/formas_de_pagamento_page.dart';
import '../pages/gerenciar_pacientes/view/gerenciar_pacientes_page.dart';
import '../pages/grupo_familiar/view/grupo_familiar_page.dart';
import '../pages/historico/historico_page.dart';
import '../pages/landing/landing_page.dart';
import '../pages/relatorios/view/relatorios_page.dart';
import '../pages/scale/view/edit_medical_scale.dart';
import '../pages/sigin/sign_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _firstNestedNavKey = GlobalKey<NavigatorState>();
final _secondNestedNavKey = GlobalKey<NavigatorState>();
final _thirdNestedNavKey = GlobalKey<NavigatorState>();

final List<String> _allowedPaths = <String>[
  LandingPage.routeName,
  SignPage.routeName,
];

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: LandingPage.routeName,
  redirect: (context, state) {
    bool isAllowedPath = _regexIncludedPaths.hasMatch(state.fullPath ?? '');
    bool isLogged = getIt<AuthService>().isLogged.value;

    if (isLogged && isAllowedPath) {
      return HomePage.routeName;
    }

    if (!isLogged && !isAllowedPath) {
      return LandingPage.routeName;
    } else {
      return null;
    }
  },
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return RootNavigator(
          navigationShell: navigationShell,
        );
      },

      // NESTED NAVIGATION
      branches: [
        StatefulShellBranch(
          navigatorKey: _firstNestedNavKey,
          routes: [
            //* HOME
            GoRoute(
              path: HomePage.routeName,
              builder: (context, state) => const HomePage(),
              routes: [
                //* GEREMCIAR PERFIL
                GoRoute(
                  path: GerenciarPacientesPage.routeName,
                  builder: (context, state) => const GerenciarPacientesPage(),
                  routes: const [],
                ),
                //* HISTORICO
                GoRoute(
                  path: HistoricoPage.routeName,
                  builder: (context, state) => const HistoricoPage(),
                  routes: const [],
                ),
                //* GRUPO FAMILIAR
                GoRoute(
                  path: GrupoFamiliarPage.routeName,
                  builder: (context, state) => const GrupoFamiliarPage(),
                  routes: const [],
                ),
                //* AVALIACAO
                GoRoute(
                  path: AvaliacoesPage.routeName,
                  builder: (context, state) => const AvaliacoesPage(),
                  routes: const [],
                ),
                GoRoute(
                  path: ReadyAvaliationPage.routeName,
                  builder: (context, state) => ReadyAvaliationPage(
                    args: state.extra as ReadyAvaliationPageArgs?,
                  ),
                  routes: const [],
                ),
                //* FORMAS DE PAGAMENTO
                GoRoute(
                  path: FormasDePagamentoPage.routeName,
                  builder: (context, state) => const FormasDePagamentoPage(),
                  routes: const [],
                ),
                //* RELATORIOS
                GoRoute(
                  path: RelatoriosPage.routeName,
                  builder: (context, state) => const RelatoriosPage(),
                  routes: const [],
                ),
                GoRoute(
                  path: EditMedicalScale.subRoute,
                  builder: (context, state) => const EditMedicalScale(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _secondNestedNavKey,
          routes: [
            //* PROFILE
            GoRoute(
              path: DoctorsPage.routeName,
              builder: (context, state) => const DoctorsPage(),
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _thirdNestedNavKey,
          routes: [
            //*DOCTOR SCALE
            GoRoute(
              path: EditMedicalScale.routeName,
              builder: (context, state) => const EditMedicalScale(),
              routes: const [],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: LandingPage.routeName,
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: SignPage.routeName,
      builder: (context, state) => const SignPage(),
    ),
  ],
);

RegExp get _regexIncludedPaths {
  final String paths = _allowedPaths.join('|');
  return RegExp(paths);
}
