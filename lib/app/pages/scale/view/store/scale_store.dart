import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/scale_repository.dart';

@injectable
class ScaleStore extends ValueNotifier<AppState> {
  final ScaleRepository _repository;
  ScaleStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> getDetails() async {
    value = AppStateLoading();
    final result = await _repository.getScales();

    if (result.scales != null) {
      value = AppStateSuccess(data: result.scales);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar escalas médicas cadastradas');
    }
  }
}
