import 'package:flutter/material.dart';
import 'package:clisp/app/pages/avaliacoes/widgets/exames_solicitados_dialog.dart';
import 'package:clisp/app/pages/avaliacoes/widgets/ficha_exames_fisicos_widget.dart';
import 'package:clisp/core/styles/text_app.dart';
import '../../../core/styles/colors_app.dart';

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
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 20, 30, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Adicionar Avaliação',
                    style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Selecionar Paciente',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(fontSize: 20, color: ColorsApp.instance.success),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.3,
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Text(
                    'Exames solicitados',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(fontSize: 20, color: ColorsApp.instance.success),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.add, color: context.colorsApp.greyColor2, size: 14),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () => showDialog(
                          context: context,
                          useSafeArea: true,
                          builder: (_) => const ExamesSolicitadosDialog(),
                        ),
                        child: Text(
                          'Selecionar Exames',
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(fontSize: 16, color: ColorsApp.instance.success),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Text(
                    'Exame Físico',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(fontSize: 20, color: ColorsApp.instance.success),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        activeColor: ColorsApp.instance.primary,
                        value: 1,
                        groupValue: 1,
                        onChanged: (value) {},
                      ),
                      Text(
                        'Normal',
                        style: context.textStyles.textPoppinsMedium
                            .copyWith(fontSize: 14, color: ColorsApp.instance.primary),
                      ),
                      const SizedBox(width: 20),
                      Radio(
                        activeColor: ColorsApp.instance.primary,
                        value: 1,
                        groupValue: 1,
                        onChanged: (value) {},
                      ),
                      Text(
                        'Alterado',
                        style: context.textStyles.textPoppinsMedium
                            .copyWith(fontSize: 14, color: ColorsApp.instance.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const FichaExameFisicoWidget(),
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
                    'Observações',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(fontSize: 20, color: ColorsApp.instance.success),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.36,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16),
                      maxLines: null,
                      expands: true,
                      textAlign: TextAlign.justify,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintStyle: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16),
                        hintText: 'Observações da consulta',
                        hintTextDirection: TextDirection.ltr,
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Text(
                    'Médico Responsável',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(fontSize: 20, color: ColorsApp.instance.success),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.3,
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
                        Text('Selecionar um médico',
                            style: context.textStyles.textPoppinsMedium
                                .copyWith(fontSize: 12, color: ColorsApp.instance.greyColor2)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
