import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/di/get_it.dart';
import 'app/root/routes.dart';
import 'firebase/prod/firebase_options.dart' as prd;
import 'firebase/dev/firebase_options.dart' as dev;

// Flavors
enum Flavor { dev, stg, prd }

// Environment
const dimension = String.fromEnvironment('dimension');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: dimension != Flavor.prd.name
        ? dev.DefaultFirebaseOptions.currentPlatform
        : prd.DefaultFirebaseOptions.currentPlatform,
  );
  await   configureDependencies();

  runApp(const ClispApp());
}

class ClispApp extends StatelessWidget {
  const ClispApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.blueGrey,
          selectedIconTheme: IconThemeData(
            size: 24,
            color: Colors.black,
          ),
          unselectedIconTheme: IconThemeData(
            size: 24,
            color: Colors.white,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.white,
          showSelectedLabels: true,
        ),
      ),
    );
  }
}
