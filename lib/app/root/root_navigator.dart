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
                    color: widget.navigationShell.currentIndex == 0 ? ColorsApp.instance.primaryColorGrean : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    widget.navigationShell.goBranch(1);
                  },
                  icon: Icon(
                    Icons.person,
                    color: widget.navigationShell.currentIndex == 1 ? ColorsApp.instance.primaryColorGrean : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    widget.navigationShell.goBranch(2);
                  },
                  icon: Icon(
                    Icons.settings,
                    color: widget.navigationShell.currentIndex == 2 ? ColorsApp.instance.primaryColorGrean : ColorsApp.instance.greyColor2,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    //TODO Fazer logout aqui
                  },
                  icon: Icon(
                    Icons.logout,
                    color: widget.navigationShell.currentIndex == 3 ? ColorsApp.instance.primaryColorGrean : ColorsApp.instance.greyColor2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: widget.navigationShell),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: widget.navigationShell.currentIndex,
      //   backgroundColor: Colors.blueAccent,
      //   onTap: (index) {
      //     if (index == 3) {
      //     } else {
      //       widget.navigationShell.goBranch(
      //         index,
      //         initialLocation: index == widget.navigationShell.currentIndex,
      //       );
      //     }
      //   },
      //   elevation: 0,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.home_outlined),
      //       activeIcon: NavIcon(
      //         iconData: Icons.home_outlined,
      //         isSelected: widget.navigationShell.currentIndex == 0,
      //       ),
      //       label: 'Início',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.person),
      //       activeIcon: NavIcon(
      //         iconData: Icons.person,
      //         isSelected: widget.navigationShell.currentIndex == 1,
      //       ),
      //       label: 'Perfil',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.settings),
      //       activeIcon: NavIcon(
      //         iconData: Icons.settings,
      //         isSelected: widget.navigationShell.currentIndex == 2,
      //       ),
      //       label: 'Ajustes',
      //     ),
      //     const BottomNavigationBarItem(
      //       icon: Icon(Icons.logout),
      //       activeIcon: NavIcon(
      //         iconData: Icons.logout,
      //         isSelected: false,
      //       ),
      //       label: 'Sair',
      //     ),
      //   ],
      // ),
    );
  }
}

// class NavIcon extends StatelessWidget {
//   final IconData iconData;
//   final bool isSelected;

//   const NavIcon({
//     Key? key,
//     required this.iconData,
//     required this.isSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: Icon(
//             iconData,
//           ),
//         ),
//         if (isSelected)
//           Positioned(
//             top: 1,
//             right: 2,
//             left: 2,
//             child: Center(
//               child: Container(
//                 width: 24,
//                 height: 2,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   // shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
