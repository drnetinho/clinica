import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/groups_repository.dart';
import '../../domain/model/family_group_model.dart';

@injectable
class DeleteGroupStore extends ValueNotifier<AppState> {
  final GroupsRepository _groupRepository;
  DeleteGroupStore(
    this._groupRepository,
  ) : super(AppStateInitial());

  Future<void> delete({required FamilyGroupModel group}) async {
    value = AppStateLoading();
    final result = await _groupRepository.deleteGroup(group: group);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: 'Erro ao excluir Grupo');
    }
  }
}

@injectable
class AddGroupStore extends ValueNotifier<AppState> {
  final GroupsRepository _repository;
  AddGroupStore(this._repository) : super(AppStateInitial());

  Future<void> generate({required FamilyGroupModel group}) async {
    value = AppStateLoading();
    final result = await _repository.generateGroup(group: group);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: 'Erro ao criar Grupo');
    }
  }
}
