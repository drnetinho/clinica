import 'package:flutter/material.dart';

class FormasDePagamentoPage extends StatefulWidget {
  static const String routeName = 'formas_de_pagamento';
  const FormasDePagamentoPage({super.key});

  @override
  State<FormasDePagamentoPage> createState() => _FormasDePagamentoPageState();
}

class _FormasDePagamentoPageState extends State<FormasDePagamentoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formas de Pagamento'),
      ),
      body: Container(),
    );
  }
}
