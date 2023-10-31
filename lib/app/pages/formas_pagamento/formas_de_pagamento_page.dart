import 'package:flutter/material.dart';
import 'package:clisp/app/pages/formas_pagamento/domain/model/pix_model.dart';
import 'package:clisp/app/pages/formas_pagamento/view/controller/formas_pagamento_controller.dart';
import 'package:clisp/app/pages/formas_pagamento/view/store/edit_pix_store.dart';
import 'package:clisp/app/pages/formas_pagamento/view/store/get_pix_store.dart';
import 'package:clisp/app/pages/formas_pagamento/view/widgets/card_dados_bancarios.dart';
import 'package:clisp/app/pages/formas_pagamento/view/widgets/editting_pix_form_widget.dart';
import 'package:clisp/core/components/store_builder.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:clisp/di/get_it.dart';

class FormasDePagamentoPage extends StatefulWidget {
  static const String routeName = 'pagamento';
  const FormasDePagamentoPage({super.key});

  @override
  State<FormasDePagamentoPage> createState() => _FormasDePagamentoPageState();
}

class _FormasDePagamentoPageState extends State<FormasDePagamentoPage> {
  // Stores

  late final EditPixStore editPixStore;
  late final GetPixStore getPixStore;

  // Controllers
  late final FormasPagamentoController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<FormasPagamentoController>();
    editPixStore = getIt<EditPixStore>();
    getPixStore = getIt<GetPixStore>();
    getPixStore.getPix();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Formas de Pagamento',
            style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 36),
          ),
          const SizedBox(height: 75),
          Text(
            'Dados Bancários   ',
            style: context.textStyles.textPoppinsSemiBold.copyWith(
              fontSize: 26,
              color: context.colorsApp.greenColor2,
            ),
          ),
          const SizedBox(height: 75),
          StoreBuilder<PixModel>(
              store: getPixStore,
              validateDefaultStates: true,
              builder: (context, pix, _) {
                return PhysicalModel(
                  elevation: 10,
                  color: context.colorsApp.backgroundCardColor,
                  borderRadius: BorderRadius.circular(20),
                  shadowColor: context.colorsApp.blackColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: AnimatedBuilder(
                      animation: Listenable.merge([controller.pixSelected, controller.editPix]),
                      builder: (context, child) {
                        if (controller.editPix.value) {
                          return EdittingPixFormWidget(
                            editPixStore: editPixStore,
                            getPixStore: getPixStore,
                            formasPagamentoController: controller,
                          );
                        } else {
                          return CardDadosBancarios(
                            editStore: editPixStore,
                            getPixStore: getPixStore,
                            pix: pix,
                            formasPagamentoController: controller,
                          );
                        }
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
    ));
  }
}
