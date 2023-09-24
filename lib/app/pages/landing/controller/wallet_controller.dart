import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/landing/form/new_group_form.dart';
import 'package:netinhoappclinica/common/form/inputs.dart';

@injectable
class WalletController {
  final TextEditingController cpfControlller = TextEditingController();

  // Form
  final ValueNotifier<WalletForm> form = ValueNotifier(WalletForm());

  void setFormListeners() {
    cpfControlller.addListener(() => form.value = form.value.copyWith(cpf: CpfInput.dirty(cpfControlller.text)));
  }
}
