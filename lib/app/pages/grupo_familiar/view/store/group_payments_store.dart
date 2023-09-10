import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/get_groups_repository.dart';
import '../../domain/model/family_payment_model.dart';

@injectable
class GroupPaymentsStore extends ValueNotifier<AppState> {
  final GetGroupsRepository _repository;
  GroupPaymentsStore(this._repository) : super(AppStateInitial());

  Future<void> getGroupPayments({required String id}) async {
    value = AppStateLoading();
    final result = await _repository.getGroupPayments(id: id);

    if (result.payments != null) {
      value = AppStateSuccess(data: result.payments);
    }
    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao buscar pagamentos do grupo');
    }
  }

  bool isPending(List<FamilyPaymnetModel> payments) => payments.any((p) => p.pending);
}
