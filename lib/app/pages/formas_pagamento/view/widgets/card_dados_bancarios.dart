import 'package:flutter/material.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';
import '../../../gerenciar_pacientes/view/widgets/editar_buttons.dart';
import '../../domain/model/pix_model.dart';
import '../controller/edit_pix_controller.dart';
import '../controller/formas_pagamento_controller.dart';
import '../store/edit_pix_store.dart';
import '../store/get_pix_store.dart';

class CardDadosBancarios extends StatefulWidget {
  final PixModel pix;
  final EditPixStore editStore;
  final GetPixStore getPixStore;

  final FormasPagamentoController formasPagamentoController;
  const CardDadosBancarios({
    super.key,
    required this.pix,
    required this.editStore,
    required this.getPixStore,
    required this.formasPagamentoController,
  });

  @override
  State<CardDadosBancarios> createState() => _CardDadosBancariosState();
}

class _CardDadosBancariosState extends State<CardDadosBancarios> {
  late final EditPixController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<EditPixController>();
  }

  Duration get animationDuration => kThemeAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.formasPagamentoController.editPix,
        builder: (context, isEditing, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: SizedBox(
                  height: 30,
                  width: 100,
                  child: EditarButton(
                    isEditing: false,
                    isLoading: widget.editStore.value.isLoading,
                    onPressed: () {
                      widget.formasPagamentoController.editPix.value = true;
                      controller.setupPix(widget.pix);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 300, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome',
                          style: context.textStyles.textPoppinsRegular.copyWith(
                            fontSize: 22,
                            color: context.colorsApp.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.pix.name,
                          style: context.textStyles.textPoppinsRegular.copyWith(
                            fontSize: 22,
                            color: context.colorsApp.blackColor,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Banco',
                          style: context.textStyles.textPoppinsRegular.copyWith(
                            fontSize: 22,
                            color: context.colorsApp.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.pix.bank,
                          style: context.textStyles.textPoppinsRegular.copyWith(
                            fontSize: 22,
                            color: context.colorsApp.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chave Pix',
                          style: context.textStyles.textPoppinsRegular.copyWith(
                            fontSize: 22,
                            color: context.colorsApp.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.pix.pixKey,
                          style: context.textStyles.textPoppinsRegular.copyWith(
                            fontSize: 22,
                            color: context.colorsApp.blackColor,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Tipo da chave',
                          style: context.textStyles.textPoppinsRegular.copyWith(
                            fontSize: 22,
                            color: context.colorsApp.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.pix.typeKey,
                          style: context.textStyles.textPoppinsRegular.copyWith(
                            fontSize: 22,
                            color: context.colorsApp.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
