import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landing';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LandingPage'),
      ),
      body: Container(),
    );
  }
}
