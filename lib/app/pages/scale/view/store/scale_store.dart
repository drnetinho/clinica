import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/common/error/app_error.dart';
import 'package:clisp/core/helps/actual_date.dart';
import 'package:clisp/core/helps/extension/date_extension.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/scale_repository.dart';
import '../../domain/model/doctor_scale.dart';

@injectable
class ScaleStore extends ValueNotifier<AppState> {
  final ScaleRepository _repository;
  ScaleStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> getScales() async {
    value = AppStateLoading();
    final result = await _repository.getScales();

    if (result.scales != null) {
      final List<DoctorScale> orderScales = result.scales!;

      // Remove older scales
      for (var scale in orderScales) {
        if (scale.isOlder) {
          orderScales.remove(scale);
        }
      }

      // Order scales by date
      orderScales.sort(
        (a, b) => a.dateTime.compareTo(b.dateTime),
      );
      value = AppStateSuccess(data: orderScales);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar escalas médicas cadastradas');
    }
  }

  DoctorScale? getDoctorOfTheDay(List<DoctorScale> scales) {
    try {
      final currentDate = scales.firstWhereOrNull(
        (element) => element.dateTime.isTheSameDay(KCurrentDate),
      );

      if (currentDate != null) {
        return currentDate;
      } else {
        var recentScale = scales.firstWhereOrNull((e) => e.dateTime.isAfter(KCurrentDate));

        if (recentScale != null) {
          for (var scale in scales) {
            if (scale.dateTime.isAfter(KCurrentDate) && scale.dateTime.isBefore(recentScale!.dateTime)) {
              recentScale = scale;
            }
          }
        }

        return recentScale;
      }
    } catch (e) {
      return null;
    }
  }
}

@injectable
class EditScaleStore extends ValueNotifier<AppState> {
  final ScaleRepository _repository;
  EditScaleStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> createScale({required DoctorScale scale}) async {
    value = AppStateLoading();
    final result = await _repository.addScale(scale: scale);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao cadastrar escala médica');
    }
  }

  Future<void> editScale({required DoctorScale scale}) async {
    value = AppStateLoading();
    final result = await _repository.editScale(scale: scale);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao atualizar escala médica');
    }
  }

  Future<void> deleteScale({required DoctorScale scale}) async {
    value = AppStateLoading();
    final result = await _repository.deleteScale(id: scale.id);

    if (result.unit != null) {
      value = AppStateSuccess(data: null);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao deletar escala médica');
    }
  }
}
