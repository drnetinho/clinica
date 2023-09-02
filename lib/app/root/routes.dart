import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/app/pages/home/view/home_page.dart';
import 'package:netinhoappclinica/app/pages/profile/profile_page.dart';
import 'package:netinhoappclinica/app/pages/settings/settings_page.dart';
import 'package:netinhoappclinica/app/root/root_navigator.dart';

import '../pages/avaliacoes/avaliacoes_page.dart';
import '../pages/formas_pagamento/formas_de_pagamento_page.dart';
import '../pages/gerenciar/gerenciar_pacientes_page.dart';
import '../pages/grupo_familiar/grupo_familiar_page.dart';
import '../pages/historico/historico_page.dart';
import '../pages/landing/landing_page.dart';
import '../pages/relatorios/relatorios_page.dart';
import '../pages/sign/sign_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _firstNestedNavKey = GlobalKey<NavigatorState>();
final _secondNestedNavKey = GlobalKey<NavigatorState>();
final _thirdNestedNavKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: LandingPage.routeName,
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
            GoRoute(path: HomePage.routeName, builder: (context, state) => const HomePage(), routes: [
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
            ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _secondNestedNavKey,
          routes: [
            //* PROFILE
            GoRoute(
              path: ProfilePage.routeName,
              builder: (context, state) => const ProfilePage(),
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _thirdNestedNavKey,
          routes: [
            //* SETTINGS
            GoRoute(
              path: SettingsPage.routeName,
              builder: (context, state) => const SettingsPage(),
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
