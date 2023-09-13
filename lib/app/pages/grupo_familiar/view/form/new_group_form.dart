import 'package:formz/formz.dart';

import '../../../../../common/form/inputs.dart';

class NewGroupForm with FormzMixin {
  final MinimumStringInput groupName;
  final StringInput monthlyFee;
  final StringInput payDate;

  NewGroupForm({
    this.groupName = const MinimumStringInput.pure(),
    this.monthlyFee = const StringInput.pure(),
    this.payDate = const StringInput.pure(),
  });

  @override
  List<FormzInput> get inputs => [
        groupName,
        monthlyFee,
        payDate,
      ];

  NewGroupForm copyWith({
    MinimumStringInput? groupName,
    StringInput? monthlyFee,
    StringInput? payDate,
  }) {
    return NewGroupForm(
      groupName: groupName ?? this.groupName,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      payDate: payDate ?? this.payDate,
    );
  }
}
