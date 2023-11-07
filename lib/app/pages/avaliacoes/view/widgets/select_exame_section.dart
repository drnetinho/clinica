import 'package:flutter/material.dart';

import 'package:clisp/app/pages/avaliacoes/view/controller/new_avaliation_controller.dart';
import 'package:clisp/app/pages/avaliacoes/view/store/avaliations_store.dart';

import '../../../../../core/styles/colors_app.dart';
import 'avaliation_label.dart';
import 'exames_solicitados_dialog.dart';

class SelectExameSection extends StatefulWidget {
  final GetAvaliationsStore? store;
  final NewAvaliationController controller;
  const SelectExameSection({
    Key? key,
    required this.store,
    required this.controller,
  }) : super(key: key);

  @override
  State<SelectExameSection> createState() => _SelectExameSectionState();
}

class _SelectExameSectionState extends State<SelectExameSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Visibility(
            visible: widget.store != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add, color: context.colorsApp.greyColor2, size: 14),
                const SizedBox(width: 4),
                InkWell(
                  onTap: widget.store != null
                      ? () {
                          showDialog(
                            context: context,
                            useSafeArea: true,
                            builder: (_) => ExamesSolicitadosDialog(
                              store: widget.store!,
                              controller: widget.controller,
                            ),
                          );
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AvaliationLabel(
                      title: 'Selecionar Exames',
                      fontSize: 14,
                      color: context.colorsApp.blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: widget.controller.exames,
            builder: (context, _) {
              return Column(
                children: List.generate(
                  widget.controller.exames.value.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check, color: context.colorsApp.primary, size: 14),
                            const SizedBox(width: 4),
                            AvaliationLabel(
                              title: widget.controller.exames.value[index],
                              fontSize: 14,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 150,
                          child: Divider(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
