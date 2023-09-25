import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../../common/state/app_state.dart';
import '../../data/repository/get_pix_repository.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

@injectable
class GetPixStore extends ValueNotifier<AppState> {
  final GetPixRepository _repository;
  GetPixStore(this._repository) : super(AppStateInitial());

  Future<void> getPix() async {
    value = AppStateLoading();
    final result = await _repository.getPix();

    if (result.pix != null) {
      value = AppStateSuccess(data: result.pix!);
    }
    if (result.error.exists) {
      value = AppStateError(message: 'Erro ao buscar dados');
    }
  }
}
