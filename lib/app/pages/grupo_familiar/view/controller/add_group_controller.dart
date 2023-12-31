import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/helps/extension/money_extension.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';

import '../../../../../core/helps/actual_date.dart';
import '../../../../../common/form/inputs.dart';
import '../../domain/model/family_payment_model.dart';
import '../form/new_group_form.dart';

@singleton
class AddGroupController {
  final TextEditingController groupNameCt = TextEditingController();
  final TextEditingController monthlyFee = TextEditingController();
  final TextEditingController payDateCt = TextEditingController();

  // Form
  final ValueNotifier<NewGroupForm> form = ValueNotifier(NewGroupForm());

  // Value Notifiers
  final ValueNotifier<FamilyGroupModel> newGroup = ValueNotifier(
    FamilyGroupModel.empty(createdAt: KCurrentDate),
  );
  final ValueNotifier<List<PatientModel>> newGroupMembers = ValueNotifier([]);
  final ValueNotifier<FamilyPaymnetModel> firstGroupPayment = ValueNotifier(
    FamilyPaymnetModel.empty(payDate: KCurrentDate, createdAt: KCurrentDate),
  );

  set addMember(PatientModel member) {
    if (!containsMember(member.id)) {
      newGroupMembers.value = [...newGroupMembers.value, member];
    }
  }

  bool containsMember(String id) => newGroupMembers.value.any((m) => m.id == id);

  void resetNewMembers() => newGroupMembers.value = [];

  set removeMember(PatientModel member) {
    newGroupMembers.value.remove(
      newGroupMembers.value.firstWhere((m) => m.id == member.id),
    );
    newGroupMembers.value = [...newGroupMembers.value];
  }

  FamilyGroupModel updateGroup() {
    newGroup.value = newGroup.value.copyWith(
      members: newGroupMembers.value.map((e) => e.id).toList(),
      name: groupNameCt.text,
      payments: const [],
    );
    return newGroup.value;
  }

  FamilyPaymnetModel updatePayment() {
    firstGroupPayment.value = firstGroupPayment.value.copyWith(
      monthlyFee: (double.tryParse(monthlyFee.text.extractCurreency) ?? 0).toCurrency,
      payDate: payDateCt.text.toDateTimeFormatted,
      pending: true,
    );
    return firstGroupPayment.value;
  }

  void resetValues() {
    groupNameCt.clear();
    payDateCt.clear();
    payDateCt.text = KCurrentDate.formatted;
    monthlyFee.clear();
    newGroupMembers.value.clear();
    form.value = NewGroupForm();

    newGroup.value = FamilyGroupModel.empty(createdAt: KCurrentDate);
    firstGroupPayment.value = FamilyPaymnetModel.empty(
      payDate: KCurrentDate,
      createdAt: KCurrentDate,
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
