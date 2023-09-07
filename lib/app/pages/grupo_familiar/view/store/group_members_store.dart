import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/get_groups_repository.dart';

@injectable
class GrupMembersStore extends ValueNotifier<AppState> {
  final GetGroupsRepository _repository;
  GrupMembersStore(this._repository) : super(AppStateInitial());

  Future<void> getGroupMembers({required List<String> ids}) async {
    value = AppStateLoading();
    final result = await _repository.getGroupMembers(ids: ids);

    if (result.members != null) {
      value = AppStateSuccess(data: result.members);
    }
    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao buscar membros do grupo');
    }
  }
}
