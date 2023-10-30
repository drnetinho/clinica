import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../grupo_familiar/data/repository/groups_repository.dart';

@injectable
class GetGroupByCpfStore extends ValueNotifier<AppState> {
  final GroupsRepository _repository;
  GetGroupByCpfStore(this._repository) : super(AppStateInitial());

  Future<void> getGroupByCpf({required String cpf}) async {
    value = AppStateLoading();
    final result = await _repository.getGroupByCpf(cpf: cpf);

    if (result.group != null) {
      value = AppStateSuccess(data: result.group);
    }
    if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar grupo');
    }
  }
}
