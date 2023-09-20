import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/state/app_state.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';
import 'package:netinhoappclinica/core/helps/extension/list_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';

import '../../data/repository/get_patients_repository.dart';

@injectable
class ManagePatientsStore extends ValueNotifier<AppState> {
  final GetPatientsRepository _repository;
  ManagePatientsStore(this._repository) : super(AppStateInitial());

  Future<void> getPatients() async {
    value = AppStateLoading();
    final result = await _repository.getPatients();

    if (result.patients.exists) {
      value = AppStateSuccess(data: result.patients!);
    }
    if (result.error.exists) {
      value = AppStateError(message:result.error?.message ?? 'Erro ao buscar dados');
    }
  }

  Future<void> getUndefiniedPatients() async {
    value = AppStateLoading();
    final result = await _repository.getPatients();

    if (result.patients.exists) {
      final list = result.patients!.where((p) => p.familyGroup.isEmpty || p.familyGroup.lower == 'a definir').toList();
      value = AppStateSuccess(data: list);
    }
    if (result.error.exists) {
      value = AppStateError(message:result.error?.message ?? 'Erro ao buscar dados');
    }
  }
}
