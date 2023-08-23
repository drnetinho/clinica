import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';
import 'package:netinhoappclinica/app/pages/gerenciar/widgets/editar_buttons.dart';
import 'package:netinhoappclinica/app/pages/gerenciar/widgets/excluir_buttons.dart';
import 'package:netinhoappclinica/app/pages/gerenciar/widgets/ficha_medica_widget.dart';

class GerenciarPacientesPage extends StatefulWidget {
  static const routeName = 'gerenciar_pacientes';
  const GerenciarPacientesPage({super.key});

  @override
  State<GerenciarPacientesPage> createState() => _GerenciarPacientesPageState();
}

class _GerenciarPacientesPageState extends State<GerenciarPacientesPage> {
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
              child: Card(
                color: context.colorsApp.backgroundCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Ficha Médica', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 22)),
                          const Spacer(),
                          ExcluirButton(onPressed: () {}),
                          const SizedBox(width: 10),
                          EditarButton(onPressed: () {})
                        ],
                      ),
                      const SizedBox(height: 20),
                      const FichaMedicaWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
