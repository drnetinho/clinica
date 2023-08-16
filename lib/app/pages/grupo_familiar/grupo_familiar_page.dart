import 'package:flutter/material.dart';

class GrupoFamiliarPage extends StatefulWidget {
  static const String routeName = 'grupo_familiar';
  const GrupoFamiliarPage({super.key});

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarPageState();
}

class _GrupoFamiliarPageState extends State<GrupoFamiliarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupo Familiar'),
      ),
      body: Container(),
    );
  }
}
