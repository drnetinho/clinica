import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/common/state/app_state.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';
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
    }
    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao buscar dados');
    }
  }

  Future<void> deletePatient({required String id}) async {
    value = AppStateLoading();
    final result = await _repository.deletePatient(id: id);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao deletar paciente');
    }
  }

  Future<void> addPatient({required PatientModel patient}) async {
    value = AppStateLoading();
    final result = await _repository.addPatient(patient: patient);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao adicionar paciente');
    }
  }
}
