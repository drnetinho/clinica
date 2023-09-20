import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/form/inputs.dart';
import '../../../../../core/helps/actual_date.dart';
import '../../../gerenciar_pacientes/domain/model/patient_model.dart';
import '../../domain/model/family_group_model.dart';
import '../form/new_group_form.dart';

@singleton
class EditGroupController {
  final TextEditingController groupNameCt = TextEditingController();

  // Form
  final ValueNotifier<NewGroupForm> form = ValueNotifier(NewGroupForm());

  // Value Notifiers
  final ValueNotifier<FamilyGroupModel> selectedGroup = ValueNotifier(
    FamilyGroupModel.empty(createdAt: KCurrentDate),
  );
  final ValueNotifier<List<PatientModel>> members = ValueNotifier([]);

  set addMember(PatientModel member) {
    if (!containsMember(member.id)) {
      members.value = [...members.value, member];
    }
  }

  bool containsMember(String id) => members.value.any((m) => m.id == id);
  void resetNewMembers() => members.value = [];

  set removeMember(PatientModel member) {
    members.value.remove(
      members.value.firstWhere((m) => m.id == member.id),
    );
    members.value = [...members.value];
  }

  FamilyGroupModel updateGroup() {
    selectedGroup.value = selectedGroup.value.copyWith(
      members: members.value.map((e) => e.id).toList(),
      name: groupNameCt.text,
      payments: const [],
    );
    return selectedGroup.value;
  }

  void resetValues() {
    groupNameCt.clear();
    members.value.clear();
    form.value = NewGroupForm();

    selectedGroup.value = FamilyGroupModel.empty(createdAt: KCurrentDate);
  }

  void setFormListeners() {
    groupNameCt
        .addListener(() => form.value = form.value.copyWith(groupName: MinimumStringInput.dirty(groupNameCt.text)));
  }
}
