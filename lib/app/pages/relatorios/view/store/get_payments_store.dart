import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';
import 'package:netinhoappclinica/core/helps/duration.dart';

import '../../../../../common/state/app_state.dart';
import '../../../../../core/helps/filter.dart';
import '../../../grupo_familiar/data/repository/group_payments_repository.dart';
import '../../../grupo_familiar/domain/model/family_group_model.dart';
import '../../../grupo_familiar/domain/model/family_payment_model.dart';

@singleton
class GetRelatoriosPaymentsStore extends ValueNotifier<AppState> {
  final GroupPaymentsRepository _repository;
  GetRelatoriosPaymentsStore(this._repository) : super(AppStateInitial());

  final ValueNotifier<List<FamilyPaymnetModel>> allPendingPayments = ValueNotifier(<FamilyPaymnetModel>[]);
  final ValueNotifier<int> undefiniedGroupsPerFilter = ValueNotifier(0);

  Future<void> getPendingPayments({String filter = FilterStrings.todos}) async {
    value = AppStateLoading();
    final result = await _repository.getAllPendingPayments();

    if (result.payments != null) {
      allPendingPayments.value = result.payments!;
      value = AppStateSuccess(data: result.payments);
    }
    if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar pagamentos');
    }
  }

  Future<void> emmitFilteredPayments(List<FamilyPaymnetModel> filteredPayments) async {
    value = AppStateLoading();
    await threeHundMili.sleep;
    value = AppStateSuccess(data: filteredPayments);
  }

  int getPending(List<FamilyGroupModel> groups, String filter) {
    int pending = 0;

    final statePayments = ((value as AppStateSuccess).data as List<FamilyPaymnetModel>);

    for (final group in groups) {
      if (statePayments.any((p) => p.familyGroupId == group.id && p.pending)) {
        pending++;
      }
    }
    return pending;
  }
}
