import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/store/patients_state.dart';
import 'package:netinhoappclinica/core/error/app_error.dart';
import 'package:netinhoappclinica/core/helps/extension/list_extension.dart';

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
      // value = AppStateSuccess(data: <PatientModel>[]);
    }

    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao buscar dados');
    }
  }
}
