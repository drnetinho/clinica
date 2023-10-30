import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../../gerenciar_pacientes/domain/model/patient_model.dart';
import '../../data/repository/groups_repository.dart';

@injectable
class GetGroupMembersStore extends ValueNotifier<AppState> {
  final GroupsRepository _repository;
  GetGroupMembersStore(this._repository) : super(AppStateInitial());

  Future<void> getGroupMembers({required List<String> ids}) async {
    value = AppStateLoading();

    if (ids.isEmpty) {
      value = AppStateSuccess(data: <PatientModel>[]);
    } else {
      final result = await _repository.getGroupMembers(ids: ids);

      if (result.members != null) {
        value = AppStateSuccess(data: result.members);
      }
      if (result.error.exists) {
        value = AppStateError(message: result.error?.message ?? 'Erro ao buscar membros do grupo');
      }
    }
  }

  void setEmptyMembers() => value = AppStateSuccess<List<PatientModel>>(data: []);
}
