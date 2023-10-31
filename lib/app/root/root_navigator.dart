import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clisp/core/styles/colors_app.dart';

import '../../clinica_icons_icons.dart';
import '../../common/services/auth/auth_service.dart';
import '../../di/get_it.dart';
import '../pages/doctors/view/doctors_page.dart';
import '../pages/home/view/home_page.dart';
import '../pages/scale/view/edit_medical_scale.dart';

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
                    ClinicaIcons.house,
                    color: widget.navigationShell.currentIndex == 0
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => context.go(DoctorsPage.routeName),
                  icon: Icon(
                    ClinicaIcons.healthicons_doctor,
                    color: widget.navigationShell.currentIndex == 1
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => context.go(EditMedicalScale.routeName),
                  icon: Icon(
                    Icons.more_time_rounded,
                    color: widget.navigationShell.currentIndex == 2
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => getIt<AuthService>().signOut(),
                  icon: Icon(
                    ClinicaIcons.signout,
                    color: ColorsApp.instance.danger,
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
