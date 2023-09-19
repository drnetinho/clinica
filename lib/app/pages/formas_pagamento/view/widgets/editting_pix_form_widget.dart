import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/app/pages/formas_pagamento/view/store/edit_pix_store.dart';
import '../../../../../core/components/app_dialog.dart';
import '../../../../../core/components/app_form_field.dart';
import '../../../../../di/get_it.dart';
import '../../../gerenciar_pacientes/view/widgets/editar_buttons.dart';
import '../controller/edit_pix_controller.dart';

import '../controller/formas_pagamento_controller.dart';
import '../forms/edit_pix_form.dart';
import '../store/get_pix_store.dart';

class EdittingPixFormWidget extends StatefulWidget {
  final EditPixStore editPixStore;
  final GetPixStore getPixStore;
  final FormasPagamentoController formasPagamentoController;
  const EdittingPixFormWidget({
    super.key,
    required this.editPixStore,
    required this.getPixStore,
    required this.formasPagamentoController,
  });

  @override
  State<EdittingPixFormWidget> createState() => _EdittingPixFormWidgetState();
}

class _EdittingPixFormWidgetState extends State<EdittingPixFormWidget> {
  late final EditPixController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<EditPixController>();
    controller.setFormListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.initControllers();
  }

  Duration get animationDuration => kThemeAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: controller.form,
          builder: (context, form, _) {
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
                      isEditing: true,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AppDialog(
                              title: 'Deseja realmente salvar as alterações?',
                              firstButtonText: 'Cancelar',
                              secondButtonText: 'Salvar',
                              firstButtonIcon: Icons.cancel,
                              secondButtonIcon: Icons.check,
                              store: widget.editPixStore,
                              onPressedSecond: () {
                                if (form.isValid) {
                                  widget.editPixStore.updatePix(pix: controller.updatePix());
                                } else {
                                  //TODO - ARTUR IMPLEMENTAR MIXN DE ERROR
                                }
                              },
                              actionOnSuccess: () {
                                widget.formasPagamentoController.editPix.value = false;
                                controller.resetValues();
                                widget.getPixStore.getPix();
                              },
                            );
                          },
                        );

                        widget.formasPagamentoController.editPix.value = false;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 10, 300, 0),
                  child: ValueListenableBuilder<EditPixForm>(
                      valueListenable: controller.form,
                      builder: (context, form, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppFormField(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  labelText: 'Nome:',
                                  controller: controller.name,
                                  isValid: form.name.isValid,
                                  validator: (_) => form.name.error?.exists,
                                  errorText: form.name.displayError?.message,
                                ),
                                AppFormField(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  labelText: 'Banco:',
                                  controller: controller.bank,
                                  isValid: form.bank.isValid,
                                  validator: (_) => form.bank.error?.exists,
                                  errorText: form.bank.displayError?.message,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppFormField(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  labelText: 'Chave Pix:',
                                  controller: controller.pixKey,
                                  isValid: form.pixKey.isValid,
                                  validator: (_) => form.pixKey.error?.exists,
                                  errorText: form.pixKey.displayError?.message,
                                ),
                                AppFormField(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  labelText: 'Tipo da Chave:',
                                  controller: controller.typeKey,
                                  isValid: form.typeKey.isValid,
                                  validator: (_) => form.typeKey.error?.exists,
                                  errorText: form.typeKey.displayError?.message,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ],
            );
          }),
    );
  }
}
