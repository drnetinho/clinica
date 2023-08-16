import 'package:flutter/material.dart';

class RelatoriosPage extends StatefulWidget {
  static const String routeName = 'relatorios';
  const RelatoriosPage({super.key});

  @override
  State<RelatoriosPage> createState() => _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
      ),
      body: Container(),
    );
  }
}
