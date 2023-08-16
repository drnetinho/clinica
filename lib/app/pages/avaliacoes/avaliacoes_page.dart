import 'package:flutter/material.dart';

class AvaliacoesPage extends StatefulWidget {
  static const String routeName = 'avaliacoes';
  const AvaliacoesPage({super.key});

  @override
  State<AvaliacoesPage> createState() => _AvaliacoesPageState();
}

class _AvaliacoesPageState extends State<AvaliacoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliações'),
      ),
      body: Container(),
    );
  }
}
