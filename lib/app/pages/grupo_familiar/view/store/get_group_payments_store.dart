import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../../../../core/helps/actual_date.dart';
import '../../../../../core/helps/duration.dart';
import '../../../relatorios/view/store/get_payments_store.dart';
import '../../data/repository/group_payments_repository.dart';
import '../../domain/model/family_payment_model.dart';

@injectable
class GetGroupPaymentsStore extends ValueNotifier<AppState> {
  final GroupPaymentsRepository _repository;
  final GetRelatoriosPaymentsStore getRelatoriosPaymentsStore;
  GetGroupPaymentsStore(
    this._repository,
    this.getRelatoriosPaymentsStore,
  ) : super(AppStateInitial());

  final ValueNotifier<List<FamilyPaymnetModel>> allGroupPayments = ValueNotifier(<FamilyPaymnetModel>[]);

  Future<void> getGroupPayments({required String id}) async {
    value = AppStateLoading();
    final result = await _repository.getGroupPayments(id: id);

    if (result.payments != null) {
      allGroupPayments.value = result.payments!;
      value = AppStateSuccess(data: result.payments);
    }
    if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar pagamentos do grupo');
    }
  }

  Future<void> emmitFilteredPayments(List<FamilyPaymnetModel> filteredPayments) async {
    // Para cada filtro aplicado, verifica se existe algum grupo que não possua pagamentos para aquele filtro
    // e portanto, este grupo é tomado com Indefinido/Undefinied
    if (filteredPayments.isEmpty) {
      getRelatoriosPaymentsStore.undefiniedGroupsPerFilter.value++;
    }

    value = AppStateLoading();
    await threeHundMili.sleep;
    value = AppStateSuccess(data: filteredPayments);
  }

  FamilyPaymnetModel? actualPayment(List<FamilyPaymnetModel> payments) {
    return payments.firstWhereOrNull(
      (e) => e.payDate.year == KCurrentDate.year && e.payDate.month == KCurrentDate.month,
    );
  }

  bool isPending(List<FamilyPaymnetModel> payments) => payments.any((p) => p.pending);
}
