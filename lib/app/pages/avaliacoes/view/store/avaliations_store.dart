import 'package:clisp/app/pages/avaliacoes/data/repository/avaliations_repository.dart';
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

  Future<void> getPatientAvaliations({required String patientId}) async {
    value = AppStateLoading();
    final result = await _repository.getPatientAvaliations(patientId: patientId);

    if (result.avaliations != null) {
      value = AppStateSuccess(data: result.avaliations);
    } else if (result.error.exists) {
      value = AppStateError(
        message: result.error?.message ?? 'Erro ao buscar avaliações cadastradas',
      );
    }
  }

  List<String> get exames => [
        'Ultrassonografia de Abdomen Total',
        'Ultrassonografia Obstétrica',
        'Ultrassonografia de Próstata',
        'Ultrassonografia de Vias Urinárias',
        'Ultrassonografia Pélvica',
        'Ultrassonografia da Tireoide',
        'Ultrassonografia Cervical',
        'Ultrassonografia Mamária',
        'Ultrassonografia Morfológica',
        'Ultrassonografia de Parede Abdominal',
        'Ultrassonografia de Bolsa Escrotal',
        'Ultrassonografia Transvaginal',
        'Eletrocardiograma',
        'Risco Cirúrgico',
        'Exames Laboratoriais',
        'Endoscopia Digestiva Alta',
        'Papanicolau (Preventivo)',
      ];
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
