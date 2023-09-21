import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/groups_repository.dart';
import '../../domain/model/family_group_model.dart';
import '../../domain/model/family_payment_model.dart';

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
      value = AppStateError(message: result.error?.message ?? 'Erro ao excluir Grupo');
    }
  }
}

@injectable
class AddGroupStore extends ValueNotifier<AppState> {
  final GroupsRepository _repository;
  AddGroupStore(this._repository) : super(AppStateInitial());

  Future<void> generate({required FamilyGroupModel group, required FamilyPaymnetModel paymnetModel}) async {
    value = AppStateLoading();
    final result = await _repository.generateGroup(
      group: group,
      paymnetModel: paymnetModel,
    );

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao criar Grupo');
    }
  }
}

@injectable
class EditGroupStore extends ValueNotifier<AppState> {
  final GroupsRepository _repository;
  EditGroupStore(this._repository) : super(AppStateInitial());

  Future<void> edit({
    required FamilyGroupModel group,
    required List<String> oldMembers,
  }) async {
    value = AppStateLoading();

    final toRemove = oldMembers.where((old) => !group.members.contains(old)).toList();
    final toAdd = group.members.where((member) => !oldMembers.contains(member)).toList();

    final result = await _repository.updateGroup(
      group: group,
      membersToRemove: toRemove,
      membersToAdd: toAdd,
    );

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao atualizar Grupo');
    }
  }
}
