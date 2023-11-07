import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/landing/form/new_group_form.dart';
import 'package:clisp/common/form/inputs.dart';

@injectable
class WalletController {
  final TextEditingController cpfControlller = TextEditingController();
  final ValueNotifier<bool> isFlipped = ValueNotifier<bool>(false);

  // Form
  final ValueNotifier<WalletForm> form = ValueNotifier(WalletForm());

  void setFormListeners() {
    cpfControlller.addListener(() => form.value = form.value.copyWith(cpf: CpfInput.dirty(cpfControlller.text)));
  }
}
