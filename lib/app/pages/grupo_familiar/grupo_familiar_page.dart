import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/widgets/grupo_familiar_widget.dart';

class GrupoFamiliarPage extends StatefulWidget {
  static const String routeName = 'grupo_familiar';
  const GrupoFamiliarPage({super.key});

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarPageState();
}

class _GrupoFamiliarPageState extends State<GrupoFamiliarPage> {
  List<String> grupoFamiliar = [
    'Thiago Fernandes Lopes',
    'Adelmo Artur de Aquino',
    'Maria de Fátima Lopes',
    'Lucas de Freitas Gomes',
    'Maria de Fátima Lopes',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: GrupoFamiliarWidget(grupoFamiliar: grupoFamiliar),
            ),
          ),
        ],
      ),
    );
  }
}
