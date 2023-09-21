import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/formas_pagamento/data/repository/get_pix_repository.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../domain/model/pix_model.dart';

@injectable
class EditPixStore extends ValueNotifier<AppState> {
  final GetPixRepository _repository;
  EditPixStore(this._repository) : super(AppStateInitial());

  Future<void> updatePix({required PixModel pix}) async {
    value = AppStateLoading();
    final result = await _repository.updatePix(pix: pix);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(message: 'Erro ao atualizar dados do pix');
    }
  }


}
