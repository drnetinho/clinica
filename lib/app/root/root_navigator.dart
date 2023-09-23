import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';

import '../../common/services/auth/auth_service.dart';
import '../../di/get_it.dart';
import '../pages/home/view/home_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/settings/settings_page.dart';

class RootNavigator extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  static const String routeName = '/';
  const RootNavigator({super.key, required this.navigationShell});

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Row(
        children: [
          Container(
            width: 60,
            height: double.infinity,
            color: ColorsApp.instance.bottonBarColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => context.go(HomePage.routeName),
                  icon: Icon(
                    Icons.home_outlined,
                    color: widget.navigationShell.currentIndex == 0
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => context.go(ProfilePage.routeName),
                  icon: Icon(
                    Icons.person,
                    color: widget.navigationShell.currentIndex == 1
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => context.go(SettingsPage.routeName),
                  icon: Icon(
                    Icons.settings,
                    color: widget.navigationShell.currentIndex == 2
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    getIt<AuthService>().isLogged.value = false;
                  },
                  icon: Icon(
                    Icons.logout,
                    color: widget.navigationShell.currentIndex == 3
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: widget.navigationShell),
        ],
      ),
    );
  }
}
