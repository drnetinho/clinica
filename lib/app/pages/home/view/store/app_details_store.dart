import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/home_repository.dart';

@injectable
class AppDetailsStore extends ValueNotifier<AppState> {
  final HomeRepository _repository;
  AppDetailsStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> getDetails() async {
    value = AppStateLoading();
    final result = await _repository.getAppDetails();

    if (result.appDetails != null) {
      value = AppStateSuccess(data: result.appDetails);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar detalhes da Clinica');
    }
  }
}
