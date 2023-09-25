import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/formas_pagamento/domain/model/pix_model.dart';

@injectable
class FormasPagamentoController extends ChangeNotifier {
  // Utils
  final List<String> typesKeys = ['CPF', 'CNPJ', 'E-mail', 'Telefone'];
  final ValueNotifier<PixModel?> pixSelected = ValueNotifier(null);

  final ValueNotifier<bool> editPix = ValueNotifier(false);
  set toogleAddNewPix(bool value) => editPix.value = value;
}
