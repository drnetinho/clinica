import 'package:flutter/material.dart';

import 'package:clisp/app/pages/avaliacoes/view/controller/new_avaliation_controller.dart';
import 'package:clisp/app/pages/avaliacoes/view/store/avaliations_store.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helps/padding.dart';
import '../../../../../core/helps/spacing.dart';

class ExamesSolicitadosDialog extends StatefulWidget {
  final GetAvaliationsStore store;
  final NewAvaliationController controller;
  const ExamesSolicitadosDialog({
    Key? key,
    required this.store,
    required this.controller,
  }) : super(key: key);

  @override
  State<ExamesSolicitadosDialog> createState() => _ExamesSolicitadosDialogState();
}

class _ExamesSolicitadosDialogState extends State<ExamesSolicitadosDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: AnimatedBuilder(
        animation: widget.controller.exames,
        builder: (context, _) {
          return SingleChildScrollView(
            child: Container(
              padding: Padd.sh(Spacing.x),
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Exames Solicitados',
                      style: context.textStyles.textPoppinsSemiBold
                          .copyWith(fontSize: 30, color: context.colorsApp.primary),
                    ),
                    const SizedBox(height: Spacing.x),
                    ...List.generate(
                      widget.store.exames.length,
                      (index) => buildItem(exame: widget.store.exames[index], index: index),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorsApp.dartWhite,
                          ),
                          onPressed: context.pop,
                          child: Row(
                            children: [
                              Icon(Icons.close, color: context.colorsApp.blackColor, size: 16),
                              const SizedBox(width: Spacing.s),
                              Text(
                                'Cancelar',
                                style: context.textStyles.textPoppinsSemiBold
                                    .copyWith(fontSize: 12, color: context.colorsApp.softBlack),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: Spacing.x),
                        ElevatedButton(
                          onPressed: context.pop,
                          child: Row(
                            children: [
                              Icon(Icons.check, color: context.colorsApp.whiteColor, size: 16),
                              const SizedBox(width: Spacing.s),
                              Text(
                                'Confirmar',
                                style: context.textStyles.textPoppinsSemiBold
                                    .copyWith(fontSize: 12, color: context.colorsApp.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildItem({required String exame, required int index}) {
    return Row(
      children: [
        Checkbox(
          activeColor: context.colorsApp.primary,
          value: widget.controller.exames.value.contains(exame),
          onChanged: (value) {
            if (value == true && !widget.controller.exames.value.contains(exame)) {
              widget.controller.addExame(exame);
            } else if (value == false && widget.controller.exames.value.contains(exame)) {
              widget.controller.removeExame(exame);
            }
          },
        ),
        const SizedBox(width: Spacing.m),
        Text(
          exame,
          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
