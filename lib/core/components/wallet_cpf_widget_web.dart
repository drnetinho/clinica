import 'package:flutter/material.dart';
import 'package:clisp/app/pages/landing/controller/wallet_controller.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/components/snackbar.dart';
import 'package:clisp/core/components/store_builder.dart';
import 'package:clisp/core/components/wallet_details.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import '../../app/pages/grupo_familiar/domain/model/family_group_model.dart';
import '../../app/pages/landing/store/get_group_cpf_store.dart';
import '../../common/form/formatters/app_formatters.dart';
import '../../di/get_it.dart';
import 'app_form_field.dart';
import 'app_loader.dart';

class WalletCPFWidgetWeb extends StatefulWidget {
  const WalletCPFWidgetWeb({
    super.key,
  });

  @override
  State<WalletCPFWidgetWeb> createState() => _WalletCPFWidgetWebState();
}

class _WalletCPFWidgetWebState extends State<WalletCPFWidgetWeb> with SnackBarMixin {
  late final GetGroupByCpfStore _getGroupByCpfStore;
  late final WalletController walletController;

  @override
  void initState() {
    super.initState();
    walletController = getIt<WalletController>();
    _getGroupByCpfStore = getIt<GetGroupByCpfStore>();
    walletController.setFormListeners();

    _getGroupByCpfStore.addListener(() {
      if (_getGroupByCpfStore.value.isError) {
        showWarning(
          context: context,
          text: 'Nenhum paciente ou grupo encontrado com o CPF informado. Informe outro CPF!',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double unitHeight = MediaQuery.of(context).size.height * 0.001;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Área do Paciente',
              style: context.textStyles.textPoppinsSemiBold.copyWith(
                color: context.colorsApp.blackColor,
                fontSize: 50 * unitHeight,
              ),
            ),
            Text(
              'Acessar Carteirinha do\nGrupo Familiar',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.blackColor, fontSize: 32 * unitHeight),
            ),
            const SizedBox(height: 60),
            Text(
              'Insira o seu CPF ou de algum participante do seu\ngrupo familiar',
              style: context.textStyles.textPoppinsSemiBold
                  .copyWith(color: context.colorsApp.blackColor, fontSize: 22 * unitHeight),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
                valueListenable: walletController.form,
                builder: (context, form, _) {
                  return AppFormField(
                    maxWidth: MediaQuery.of(context).size.width * 0.3,
                    controller: walletController.cpfControlller,
                    isValid: form.cpf.isValid,
                    onSubmit: (p0) {
                      if (form.isValid) {
                        _getGroupByCpfStore.getGroupByCpf(cpf: walletController.cpfControlller.text);
                      } else {
                        showError(context: context, text: 'CPF inválido');
                      }
                    },
                    validator: (_) => form.cpf.error?.exists,
                    errorText: form.cpf.displayError?.message,
                    inputFormatters: [AppFormatters.cpfInputFormatter],
                  );
                }),
            const SizedBox(height: 20),
            AnimatedBuilder(
                animation: _getGroupByCpfStore,
                builder: (context, _) {
                  return ValueListenableBuilder(
                      valueListenable: walletController.form,
                      builder: (context, form, _) {
                        return SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: form.isValid
                                ? () {
                                    if (form.isValid) {
                                      _getGroupByCpfStore.getGroupByCpf(cpf: walletController.cpfControlller.text);
                                    } else {
                                      showError(context: context, text: 'CPF inválido');
                                    }
                                  }
                                : null,
                            child: _getGroupByCpfStore.value.isLoading
                                ? AppLoader(
                                    size: 20,
                                    color: ColorsApp.instance.whiteColor,
                                  )
                                : const Text('Acessar'),
                          ),
                        );
                      });
                })
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 60),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
            width: MediaQuery.of(context).size.height * 0.8,
            child: StoreBuilder<FamilyGroupModel>(
              store: _getGroupByCpfStore,
              validateDefaultStates: false,
              builder: (context, group, _) => WalletDetails(group: group),
            ),
          ),
        )
      ],
    );
  }
}
