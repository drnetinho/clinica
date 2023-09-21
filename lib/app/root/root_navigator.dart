import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';

class RootNavigator extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  static const String routeName = '/';
  const RootNavigator({super.key, required this.navigationShell});

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
                  onPressed: () {
                    widget.navigationShell.goBranch(0);
                  },
                  icon: Icon(
                    Icons.home_outlined,
                    color: widget.navigationShell.currentIndex == 0
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    widget.navigationShell.goBranch(1);
                  },
                  icon: Icon(
                    Icons.person,
                    color: widget.navigationShell.currentIndex == 1
                        ? ColorsApp.instance.success
                        : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    widget.navigationShell.goBranch(2);
                  },
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
                    //TODO Fazer logout aqui
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
