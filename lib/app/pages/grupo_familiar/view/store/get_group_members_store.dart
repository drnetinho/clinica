import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../../gerenciar_pacientes/domain/model/patient_model.dart';
import '../../data/repository/get_groups_repository.dart';

@injectable
class GetGroupMembersStore extends ValueNotifier<AppState> {
  final GetGroupsRepository _repository;
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
        value = AppStateError(message: 'Erro ao buscar membros do grupo');
      }
    }
  }

  void setEmptyMembers() => value = AppStateSuccess<List<PatientModel>>(data: []);
}
