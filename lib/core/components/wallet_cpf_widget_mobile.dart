import 'package:flutter/material.dart';

import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';
import 'package:netinhoappclinica/core/components/wallet_details.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../app/pages/grupo_familiar/domain/model/family_group_model.dart';
import '../../app/pages/landing/controller/wallet_controller.dart';
import '../../app/pages/landing/store/get_group_cpf_store.dart';
import '../../common/form/formatters/app_formatters.dart';
import '../../di/get_it.dart';
import 'app_form_field.dart';
import 'app_loader.dart';

class WalletCpfWidgetMobile extends StatefulWidget {
  final VoidCallback onFindGroup;
  const WalletCpfWidgetMobile({
    Key? key,
    required this.onFindGroup,
  }) : super(key: key);

  @override
  State<WalletCpfWidgetMobile> createState() => _WalletCpfWidgetMobileState();
}

class _WalletCpfWidgetMobileState extends State<WalletCpfWidgetMobile> with SnackBarMixin {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Acessar Carteirinha do Grupo Familiar',
                style:
                    context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.blackColor, fontSize: 12),
              ),
              const SizedBox(height: 10),
              Text(
                'Insira o CPF de  algum participante do seu grupo familiar',
                style:
                    context.textStyles.textPoppinsRegular.copyWith(color: context.colorsApp.blackColor, fontSize: 10),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: walletController.form,
                builder: (context, form, _) {
                  return AppFormField(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
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
                },
              ),
              AnimatedBuilder(
                animation: _getGroupByCpfStore,
                builder: (context, _) {
                  return ValueListenableBuilder(
                    valueListenable: walletController.form,
                    builder: (context, form, _) {
                      return SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.8,
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
                    },
                  );
                },
              ),
              const SizedBox(height: 40),
              StoreBuilder<FamilyGroupModel>(
                store: _getGroupByCpfStore,
                validateDefaultStates: false,
                builder: (context, group, _) => WalletDetails(
                  group: group,
                  fromMobile: true,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
