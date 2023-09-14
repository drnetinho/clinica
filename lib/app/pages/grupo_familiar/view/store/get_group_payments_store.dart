import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../../../../core/helps/actual_date.dart';
import '../../data/repository/group_payments_repository.dart';
import '../../domain/model/family_payment_model.dart';

@injectable
class GetGroupPaymentsStore extends ValueNotifier<AppState> {
  final GroupPaymentsRepository _repository;
  GetGroupPaymentsStore(this._repository) : super(AppStateInitial());

  Future<void> getGroupPayments({required String id}) async {
    value = AppStateLoading();
    final result = await _repository.getGroupPayments(id: id);

    if (result.payments != null) {
      value = AppStateSuccess(data: result.payments);
    }
    if (result.error.exists) {
      value = AppStateError(message: 'Erro ao buscar pagamentos do grupo');
    }
  }

  FamilyPaymnetModel? actualPayment(List<FamilyPaymnetModel> payments) {
    return payments.firstWhereOrNull(
      (e) => e.payDate.year == KCurrentDate.year && e.payDate.month == KCurrentDate.month,
    );
  }

  bool isPending(List<FamilyPaymnetModel> payments) => payments.any((p) => p.pending);
}
