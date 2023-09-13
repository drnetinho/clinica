import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';

import '../../../../../core/helps/actual_date.dart';
import '../../../../../common/form/inputs.dart';
import '../form/new_group_form.dart';

@singleton
class AddGrupoFamiliarController {
  final TextEditingController groupNameCt = TextEditingController();
  final TextEditingController monthlyFee = TextEditingController();
  final TextEditingController payDateCt = TextEditingController();

  // Form
  final ValueNotifier<NewGroupForm> form = ValueNotifier(NewGroupForm());

  // Value Notifiers
  final ValueNotifier<FamilyGroupModel> newGroup = ValueNotifier(
    const FamilyGroupModel.empty(),
  );
  final ValueNotifier<List<String>> newGroupMembers = ValueNotifier([]);
  final ValueNotifier<FamilyPaymnetModel> newGroupPayment = ValueNotifier(FamilyPaymnetModel.empty(
    payDate: KCurrentDate,
  ));

  set addMembers(List<String> members) => newGroupMembers.value = [
        ...newGroupMembers.value,
        ...members,
      ];

  FamilyGroupModel updateGroup() {
    newGroup.value = newGroup.value.copyWith(
      members: newGroupMembers.value,
      name: groupNameCt.text,
      payments: const [],
    );
    return newGroup.value;
  }

  void resetValues() {
    groupNameCt.clear();
    payDateCt.clear();
    payDateCt.text = KCurrentDate.formatted;
    monthlyFee.clear();
    newGroupMembers.value.clear();
    form.value = NewGroupForm();

    newGroup.value = const FamilyGroupModel.empty();
    newGroupPayment.value = FamilyPaymnetModel.empty(
      payDate: KCurrentDate,
    );
  }

  void setInitialPayDate() => payDateCt.text = KCurrentDate.formatted;

  void setFormListeners() {
    groupNameCt
        .addListener(() => form.value = form.value.copyWith(groupName: MinimumStringInput.dirty(groupNameCt.text)));
    monthlyFee.addListener(() => form.value = form.value.copyWith(monthlyFee: StringInput.dirty(monthlyFee.text)));
    payDateCt.addListener(() => form.value = form.value.copyWith(payDate: StringInput.dirty(payDateCt.text)));
  }
}
