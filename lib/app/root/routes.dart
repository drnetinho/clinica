import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/app/pages/home/home_page.dart';
import 'package:netinhoappclinica/app/pages/profile/profile_page.dart';
import 'package:netinhoappclinica/app/pages/settings/settings_page.dart';
import 'package:netinhoappclinica/app/root/root_navigator.dart';

import '../pages/landing/landing_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _firstNestedNavKey = GlobalKey<NavigatorState>();
final _secondNestedNavKey = GlobalKey<NavigatorState>();
final _thirdNestedNavKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: HomePage.routeName,
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
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _secondNestedNavKey,
          routes: [
            //* PROFILE
            GoRoute(
              path: ProfilePage.routeName,
              builder: (context, state) => const ProfilePage(),
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
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: LandingPage.routeName,
      builder: (context, state) => const LandingPage(),
    ),
  ],
);
