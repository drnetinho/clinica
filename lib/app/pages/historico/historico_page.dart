import 'package:flutter/material.dart';

class HistoricoPage extends StatefulWidget {
  static const String routeName = 'historico';
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico'),
      ),
      body: Container(),
    );
  }
}
