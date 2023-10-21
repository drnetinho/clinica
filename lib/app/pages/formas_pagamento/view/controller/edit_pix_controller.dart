import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/form/inputs.dart';
import '../../domain/model/pix_model.dart';
import '../forms/edit_pix_form.dart';

@singleton
class EditPixController {
  final TextEditingController name = TextEditingController();
  final TextEditingController bank = TextEditingController();
  final TextEditingController pixKey = TextEditingController();
  final TextEditingController typeKey = TextEditingController();

  final ValueNotifier<String> selectedTipeKey = ValueNotifier('');

  //form
  final ValueNotifier<EditPixForm> form = ValueNotifier(EditPixForm());

  // Value Notifiers

  final ValueNotifier<PixModel> pixEdited = ValueNotifier(const PixModel.initial());

  final List<String> typeKeys = ['CPF', 'CNPJ', 'E-mail', 'Telefone', 'Chave aleatória'];

  set setTypeKey(String key) {
    selectedTipeKey.value = key;
    typeKey.text = selectedTipeKey.value;
  }

  void setupPix(PixModel pix) {
    pixEdited.value = pix;
  }

  PixModel updatePix() {
    pixEdited.value = pixEdited.value.copyWith(
      typeKey: typeKey.text,
      bank: bank.text,
      key: pixKey.text,
      name: name.text,
    );
    return pixEdited.value;
  }

  void setFormListeners() {
    typeKey.addListener(() => form.value = form.value.copyWith(typeKey: StringInput.dirty(typeKey.text)));
    bank.addListener(() => form.value = form.value.copyWith(bank: StringInput.dirty(bank.text)));
    pixKey.addListener(() => form.value = form.value.copyWith(pixKey: StringInput.dirty(pixKey.text)));
    name.addListener(() => form.value = form.value.copyWith(name: StringInput.dirty(name.text)));
  }

  void resetValues() {
    form.value = EditPixForm();
    typeKey.clear();
    bank.clear();
    pixKey.clear();
    name.clear();
  }

  void initControllers() {
    typeKey.text = pixEdited.value.typeKey;
    bank.text = pixEdited.value.bank;
    pixKey.text = pixEdited.value.pixKey;
    name.text = pixEdited.value.name;
  }
}
