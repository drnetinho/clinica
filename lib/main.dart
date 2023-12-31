import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/root/routes.dart';
import 'common/services/remote_config/remote_config_service.dart';
import 'core/styles/colors_app.dart';
import 'di/get_it.dart';
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
  await RMConfig.instance.initialize();
  await configureDependencies();

  runApp(const ClispApp());
}

class ClispApp extends StatelessWidget {
  const ClispApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: goRouter.routerDelegate,
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('pt', 'BR')],
      theme: ThemeData(
        dialogBackgroundColor: ColorsApp.instance.backgroundCardColor,
        scaffoldBackgroundColor: ColorsApp.instance.whiteColor,
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          surfaceTintColor: ColorsApp.instance.backgroundCardColor,
          backgroundColor: ColorsApp.instance.backgroundCardColor,
        ),
        popupMenuTheme: PopupMenuThemeData(
          surfaceTintColor: ColorsApp.instance.backgroundCardColor,
          color: ColorsApp.instance.backgroundCardColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: ColorsApp.instance.whiteColor,
            backgroundColor: ColorsApp.instance.success,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: context.colorsApp.greyColor2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: context.colorsApp.greyColor2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: context.colorsApp.greyColor2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: context.colorsApp.danger,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: context.colorsApp.danger,
            ),
          ),
          // isDense: true,
        ),
      ),
    );
  }
}
