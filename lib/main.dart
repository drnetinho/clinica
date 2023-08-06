import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello Worldd!'),
        ),
      ),
    );
  }
}
