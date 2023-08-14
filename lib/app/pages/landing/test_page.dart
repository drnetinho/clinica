import 'package:flutter/material.dart';

class TestePage extends StatefulWidget {
  static const String routeName = '/teste-page';
  const TestePage({super.key});

  @override
  State<TestePage> createState() => _TestePageState();
}

class _TestePageState extends State<TestePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(TestePage.routeName),
      ),
    );
  }
}
