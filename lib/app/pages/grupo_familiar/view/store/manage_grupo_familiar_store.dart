import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/get_groups_repository.dart';
import '../../domain/model/family_group_model.dart';

@injectable
class ManageGrupoFamiliarStore extends ValueNotifier<AppState> {
  final GetGroupsRepository _repository;
  ManageGrupoFamiliarStore(this._repository) : super(AppStateInitial());

  Future<void> delete({required FamilyGroupModel group}) async {
    value = AppStateLoading();
    final result = await _repository.deleteGroup(group: group);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(error: 'Erro ao reverter pagamento');
    }
  }

  Future<void> generate({required FamilyGroupModel group}) async {
    value = AppStateLoading();
    final result = await _repository.generateGroup(group: group);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(error: 'Erro ao reverter pagamento');
    }
  }
}
