import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/get_groups_repository.dart';
import '../../domain/model/family_payment_model.dart';

@injectable
class EditPaymentsStore extends ValueNotifier<AppState> {
  final GetGroupsRepository _repository;
  EditPaymentsStore(this._repository) : super(AppStateInitial());

  final actualDate = DateTime.now();

  Future<void> confirmPendingPayment({
    required FamilyPaymnetModel payment,
    required bool generateNextPayment,
  }) async {
    value = AppStateLoading();
    final result = await _repository.editPayment(
      payment: payment.copyWith(
        pending: false,
        receiveDate: DateTime.now().toLocal(),
      ),
    );

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
      if (generateNextPayment) {
        await _generateNextPayment(oldPaymenteBase: payment);
      }
    }

    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao confirmar pagamento');
    }
  }

  Future<void> newPayment({required String familyGroupId}) async {
    value = AppStateLoading();
    // TODO dar opcao de alterar data
    final result = await _repository.generatePayment(
      newPayment: FamilyPaymnetModel.empty(
        familyGroupId: familyGroupId,
        payDate: actualDate,
      ),
    );

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }

    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao confirmar pagamento');
    }
  }

  Future<void> _generateNextPayment({required FamilyPaymnetModel oldPaymenteBase}) async {
    value = AppStateLoading();
    final result = await _repository.generatePayment(
      newPayment: FamilyPaymnetModel.empty(
        familyGroupId: oldPaymenteBase.familyGroupId,
        monthlyFee: oldPaymenteBase.monthlyFee,
        payDate: oldPaymenteBase.payDate.copyWith(
          month: oldPaymenteBase.payDate.month + 1,
        ),
      ),
    );

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(error: 'Erro ao gerar novo pagamento');
    }
  }
}
