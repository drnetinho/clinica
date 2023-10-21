import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/formas_pagamento/view/store/edit_pix_store.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
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

class _EdittingPixFormWidgetState extends State<EdittingPixFormWidget> with SnackBarMixin {
  late final EditPixController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<EditPixController>();
    controller.setFormListeners();
    widget.editPixStore.addListener(pixListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.initControllers();
  }

  @override
  void dispose() {
    widget.editPixStore.removeListener(pixListener);
    super.dispose();
  }

  void pixListener() {
    if (widget.editPixStore.value.isSuccess) {
      showSuccess(
        context: context,
        text: 'Pix atualizado com sucesso!',
      );
    }
  }

  Duration get animationDuration => kThemeAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.form,
        builder: (context, form, _) {
          return PhysicalModel(
            elevation: 10,
            color: context.colorsApp.backgroundCardColor,
            borderRadius: BorderRadius.circular(20),
            shadowColor: context.colorsApp.blackColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.formasPagamentoController.editPix.value = false;
                          controller.resetValues();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorsApp.dartWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: context.colorsApp.dartWhite,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.close, color: context.colorsApp.blackColor, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'Cancelar',
                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                fontSize: 12,
                                color: context.colorsApp.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
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
                                      showError(
                                        context: context,
                                        text: 'Erro ao atualizar Pix. Tente novamente!',
                                      );
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 10, 300, 0),
                  child: ValueListenableBuilder<EditPixForm>(
                    valueListenable: controller.form,
                    builder: (context, form, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       'Tipo da Chave:',
                              //       style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
                              //     ),
                              //     Spacing.s.verticalGap,
                              //     Container(
                              //       height: 45,
                              //       width: 200,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(Spacing.m),
                              //         border: Border.all(color: context.colorsApp.primary),
                              //       ),
                              //       child: InkWell(
                              //         onTap: () {
                              //           showDialog(
                              //             context: context,
                              //             builder: (context) {
                              //               return Dialog(
                              //                   child: SizedBox(
                              //                 height: 200,
                              //                 width: 200,
                              //                 child: ListView.builder(
                              //                   itemCount: controller.typeKeys.length,
                              //                   itemBuilder: (context, index) {
                              //                     return ListTile(
                              //                       title: Text(
                              //                         controller.typeKeys[index],
                              //                         style: context.textStyles.textPoppinsMedium.copyWith(
                              //                           fontSize: 14,
                              //                           color: context.colorsApp.primary,
                              //                         ),
                              //                       ),
                              //                       onTap: () {
                              //                         controller.typeKey.text = controller.typeKeys[index];
                              //                         Navigator.pop(context);
                              //                       },
                              //                     );
                              //                   },
                              //                 ),
                              //               ));
                              //             },
                              //           );
                              //         },
                              //         child: Padding(
                              //           padding: const EdgeInsets.symmetric(horizontal: 10),
                              //           child: Row(
                              //             children: [
                              //               Text(
                              //                 controller.typeKey.text,
                              //                 style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
                              //               ),
                              //               const Spacer(),
                              //               Icon(Icons.keyboard_arrow_down_rounded,
                              //                   color: context.colorsApp.primary, size: 30)
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // )

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
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
