import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/landing/controller/wallet_controller.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import '../../app/pages/landing/store/get_group_cpf_store.dart';
import '../../common/form/formatters/app_formatters.dart';
import '../../di/get_it.dart';
import 'app_form_field.dart';

class WalletCPFWidget extends StatefulWidget {
  const WalletCPFWidget({
    super.key,
  });

  @override
  State<WalletCPFWidget> createState() => _WalletCPFWidgetState();
}

class _WalletCPFWidgetState extends State<WalletCPFWidget> with SnackBarMixin {
  late final GetGroupByCpfStore _getGroupByCpfStore;
  late final WalletController walletController;

  @override
  void initState() {
    super.initState();
    walletController = getIt<WalletController>();
    _getGroupByCpfStore = getIt<GetGroupByCpfStore>();
    walletController.setFormListeners();
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
              'Insira o CPF de  algum participante do seu\ngrupo familiar',
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
                    validator: (_) => form.cpf.error?.exists,
                    errorText: form.cpf.displayError?.message,
                    inputFormatters: [AppFormatters.cpfInputFormatter],
                  );
                }),
            const SizedBox(height: 20),
            ValueListenableBuilder(
                valueListenable: walletController.form,
                builder: (context, form, _) {
                  return SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      child: const Text('Acessar'),
                      onPressed: () {
                        if (form.isValid) {
                          _getGroupByCpfStore.getGroupByCpf(cpf: walletController.cpfControlller.text);
                        } else {
                          showError(context: context, text: 'CPF inválido');
                        }
                      },
                    ),
                  );
                })
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset('assets/images/Group.png'),
          ),
        )
      ],
    );
  }
}
