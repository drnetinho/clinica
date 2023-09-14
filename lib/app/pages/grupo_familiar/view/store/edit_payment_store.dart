import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../../../../core/helps/actual_date.dart';
import '../../data/repository/group_payments_repository.dart';
import '../../domain/model/family_payment_model.dart';

@injectable
class EditPaymentsStore extends ValueNotifier<AppState> {
  final GroupPaymentsRepository _repository;
  EditPaymentsStore(this._repository) : super(AppStateInitial());

  Future<void> confirmPending({
    required FamilyPaymnetModel payment,
    required bool generateNext,
  }) async {
    value = AppStateLoading();
    final result = await _repository.editPayment(
      payment: payment.copyWith(
        pending: false,
        receiveDate: KCurrentDate.toLocal(),
      ),
    );
    if (result.unit != null) {
      value = AppStateSuccess(data: null);
      if (generateNext) {
        await _generateNext(oldPaymenteBase: payment);
      }
    }
    if (result.error.exists) {
      value = AppStateError(message: 'Erro ao confirmar pagamento');
    }
  }

  Future<void> generate({required String groupId}) async {
    value = AppStateLoading();

    final result = await _repository.generatePayment(
      newPayment: FamilyPaymnetModel.empty(
        familyGroupId: groupId,
        payDate: KCurrentDate,
        createdAt: KCurrentDate,
      ),
    );
    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(message: 'Erro ao confirmar pagamento');
    }
  }

  Future<void> delete({
    required FamilyPaymnetModel payment,
  }) async {
    value = AppStateLoading();
    final result = await _repository.deletePayment(payment: payment);
    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: 'Erro ao deletar pagamento');
    }
  }

  Future<void> revert({
    required FamilyPaymnetModel payment,
  }) async {
    value = AppStateLoading();
    final result = await _repository.editPayment(
      payment: FamilyPaymnetModel.empty(
        familyGroupId: payment.familyGroupId,
        payDate: payment.payDate,
        id: payment.id,
        monthlyFee: payment.monthlyFee,
        pending: true,
        receiveDate: null,
          createdAt: KCurrentDate,
      ),
    );
    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: 'Erro ao reverter pagamento');
    }
  }

  Future<void> _generateNext({required FamilyPaymnetModel oldPaymenteBase}) async {
    value = AppStateLoading();
    final result = await _repository.generatePayment(
      newPayment: FamilyPaymnetModel.empty(
        familyGroupId: oldPaymenteBase.familyGroupId,
        monthlyFee: oldPaymenteBase.monthlyFee,
        payDate: oldPaymenteBase.payDate.copyWith(
          month: oldPaymenteBase.payDate.month + 1,
        ),
          createdAt: KCurrentDate,
      ),
    );

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    }
    if (result.error.exists) {
      value = AppStateError(message: 'Erro ao gerar novo pagamento');
    }
  }
}
