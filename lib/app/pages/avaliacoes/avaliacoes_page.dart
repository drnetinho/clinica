import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import '../../../core/styles/colors_app.dart';

class AvaliacoesPage extends StatefulWidget {
  static const String routeName = 'avaliacoes';

  const AvaliacoesPage({super.key});

  @override
  State<AvaliacoesPage> createState() => _AvaliacoesPageState();
}

class _AvaliacoesPageState extends State<AvaliacoesPage> {
  final EC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 20, 30, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adicionar Avaliação',
                    style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Escolher Paciente',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(fontSize: 20, color: ColorsApp.instance.success),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsApp.instance.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_add),
                        Text('Selecionar Paciente',
                            style: context.textStyles.textPoppinsMedium
                                .copyWith(fontSize: 12, color: ColorsApp.instance.greyColor2)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Anexar Relatório da consulta',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(fontSize: 20, color: ColorsApp.instance.success),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsApp.instance.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload_file_rounded),
                        Text(
                          'Arraste o arquivo aqui',
                          style: context.textStyles.textPoppinsMedium
                              .copyWith(fontSize: 16, color: ColorsApp.instance.success),
                        ),
                        Text(
                          'Ou clique para selecionar',
                          style: context.textStyles.textPoppinsMedium
                              .copyWith(fontSize: 12, color: ColorsApp.instance.greyColor2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 110, 100, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avaliações',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(fontSize: 20, color: ColorsApp.instance.success),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Card(
                      color: ColorsApp.instance.backgroundCardColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: ColorsApp.instance.greyColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: EC,
                          maxLines: null,
                          expands: true,
                          decoration: const InputDecoration(
                            hintText: 'Observações da consulta',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Icon(Icons.check),
                            Text("Salvar"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
