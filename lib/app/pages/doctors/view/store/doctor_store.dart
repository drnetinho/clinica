import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/doctors/data/repository/doctors_repository.dart';
import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';

@injectable
class DoctorStore extends ValueNotifier<AppState> {
  final DoctorRepository _repository;
  DoctorStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> getDoctors() async {
    value = AppStateLoading();
    final result = await _repository.getDoctors();

    if (result.doctors != null) {
      value = AppStateSuccess(data: result.doctors);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar médicos cadastrados');
    }
  }

  Doctor? getDoctorFromList(String? id, List<Doctor> doctors) {
    if (id == null) return null;
    return doctors.firstWhereOrNull((element) => element.id == id);
  }
}

@injectable
class GetDoctorStore extends ValueNotifier<AppState> {
  final DoctorRepository _repository;
  GetDoctorStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> getDoctorById(String id) async {
    value = AppStateLoading();
    final result = await _repository.getDoctorById(id: id);

    if (result.doctor != null) {
      value = AppStateSuccess(data: result.doctor);
    } else {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar médicos cadastrados');
    }
  }
}
