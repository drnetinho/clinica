import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/doctors/data/repository/doctors_repository.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';

@injectable
class DoctorStore extends ValueNotifier<AppState> {
  final DoctorRepository _repository;
  DoctorStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> getDetails() async {
    value = AppStateLoading();
    final result = await _repository.getDoctors();

    if (result.doctors != null) {
      value = AppStateSuccess(data: result.doctors);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar médicos cadastrados');
    }
  }
}
