import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/get_patients_repository.dart';
import '../../domain/model/patient_model.dart';

@injectable
class EditPatientsStore extends ValueNotifier<AppState> {
  final GetPatientsRepository _repository;
  EditPatientsStore(this._repository) : super(AppStateInitial());

  Future<void> deletePatient({required String id}) async {
    value = AppStateLoading();
    final result = await _repository.deletePatient(id: id);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(message:result.error?.message ?? 'Erro ao deletar paciente');
    }
  }

  Future<void> updatePatient({required PatientModel patient}) async {
    value = AppStateLoading();
    final result = await _repository.updatePatient(patient: patient);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao atualizar dados do paciente');
    }
  }

  Future<void> addPatient({required PatientModel patient}) async {
    value = AppStateLoading();
    final result = await _repository.addPatient(patient: patient);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(message:result.error?.message ?? 'Erro ao adicionar paciente');
    }
  }
}
