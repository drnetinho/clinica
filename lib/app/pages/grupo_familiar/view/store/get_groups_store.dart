import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/groups_repository.dart';

@singleton
class GetGroupsStore extends ValueNotifier<AppState> {
  final GroupsRepository _repository;
  GetGroupsStore(this._repository) : super(AppStateInitial());

  Future<void> getGroups() async {
    value = AppStateLoading();
    final result = await _repository.getGroups();

    if (result.groups != null) {
      value = AppStateSuccess(data: result.groups);
    }
    if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar grupos');
    }
  }
}
