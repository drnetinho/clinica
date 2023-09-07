import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/get_groups_repository.dart';

@injectable
class GrupoFamiliarStore extends ValueNotifier<AppState> {
  final GetGroupsRepository _repository;
  GrupoFamiliarStore(this._repository) : super(AppStateInitial());

  Future<void> getGroups() async {
    value = AppStateLoading();
    final result = await _repository.getGroups();

    if (result.groups != null) {
      value = AppStateSuccess(data: result.groups);
    }
    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao buscar grupos');
    }
  }
}
