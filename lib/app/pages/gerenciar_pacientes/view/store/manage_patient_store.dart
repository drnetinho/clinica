import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/common/state/app_state.dart';
import 'package:clisp/common/error/app_error.dart';
import 'package:clisp/core/helps/extension/list_extension.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';

import '../../data/repository/get_patients_repository.dart';

@singleton
class ManagePatientsStore extends ValueNotifier<AppState> {
  final GetPatientsRepository _repository;
  ManagePatientsStore(this._repository) : super(AppStateInitial());

  Future<void> getPatients() async {
    value = AppStateLoading();
    final result = await _repository.getPatients();

    if (result.patients.noNull) {
      value = AppStateSuccess(data: result.patients!);
      final undefinied =
          result.patients!.where((p) => p.familyGroup.isEmpty || p.familyGroup.lower == 'a definir').toList();
      undefiniedPatients.value = undefinied;
    }
    if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar dados');
    }
  }

  final ValueNotifier<List<PatientModel>> undefiniedPatients = ValueNotifier([]);
}
