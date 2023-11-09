import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/doctors/data/repository/doctors_repository.dart';
import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/common/error/app_error.dart';
import 'package:clisp/common/services/remote_config/remote_config_service.dart';
import 'package:clisp/common/services/storage/firebase_storage.dart';

import '../../../../../common/state/app_state.dart';

@injectable
class EditDoctorStore extends ValueNotifier<AppState> {
  final DoctorRepository _repository;
  EditDoctorStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> editDoctor(Doctor doctor) async {
    value = AppStateLoading();
    final result = await _repository.editDoctor(doctor: doctor);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao editar médico');
    }
  }

  Future<void> deleteDoctor(Doctor doctor) async {
    value = AppStateLoading();
    if (doctor.image != RMConfig.instance.emptyAvatar) {
      StorageService.deleteImage(doctor.image);
    }
    final result = await _repository.deleteDoctor(id: doctor.id);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao deletar médico');
    }
  }

  Future<void> createDoctor(Doctor doctor) async {
    Doctor newDoctor = doctor;
    value = AppStateLoading();

    if (doctor.image.isEmpty) {
      newDoctor = doctor.copyWith(image: RMConfig.instance.emptyAvatar);
    }
    final result = await _repository.addDoctor(doctor: newDoctor);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao registrar novo médico');
    }
  }
}
