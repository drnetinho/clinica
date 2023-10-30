import 'package:clisp/app/pages/avaliacoes/data/repository/doctors_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/common/error/app_error.dart';

import '../../../../../common/state/app_state.dart';
import '../../domain/model/avaliation.dart';

@injectable
class GetAvaliationsStore extends ValueNotifier<AppState> {
  final AvaliationsRepository _repository;
  GetAvaliationsStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> getAvaliations() async {
    value = AppStateLoading();
    final result = await _repository.getAvaliations();

    if (result.avaliations != null) {
      value = AppStateSuccess(data: result.avaliations);
    } else if (result.error.exists) {
      value = AppStateError(
        message: result.error?.message ?? 'Erro ao buscar avaliações cadastradas',
      );
    }
  }
}

@injectable
class EditAvaliationsStore extends ValueNotifier<AppState> {
  final AvaliationsRepository _repository;
  EditAvaliationsStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> editAvaliation(Avaliation avaliation) async {
    value = AppStateLoading();
    final result = await _repository.editAvaliation(avaliation: avaliation);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(
        message: result.error?.message ?? 'Erro ao editar avaliação',
      );
    }
  }

  Future<void> deleteAvaliation(Avaliation avaliation) async {
    value = AppStateLoading();
    final result = await _repository.deleteAvaliation(id: avaliation.id);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(
        message: result.error?.message ?? 'Erro ao deletar avaliação',
      );
    }
  }

  Future<void> createAvaliation(Avaliation avaliation) async {
    value = AppStateLoading();

    final result = await _repository.addAvaliation(avaliation: avaliation);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(
        message: result.error?.message ?? 'Erro ao registrar nova avaliação',
      );
    }
  }
}
