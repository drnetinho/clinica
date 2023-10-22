import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/error/app_error.dart';
import 'package:netinhoappclinica/core/helps/actual_date.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';

import '../../../../../common/state/app_state.dart';
import '../../data/repository/scale_repository.dart';
import '../../domain/model/doctor_scale.dart';

@injectable
class ScaleStore extends ValueNotifier<AppState> {
  final ScaleRepository _repository;
  ScaleStore(
    this._repository,
  ) : super(AppStateInitial());

  Future<void> getScale() async {
    value = AppStateLoading();
    final result = await _repository.getScales();

    if (result.scales != null) {
      value = AppStateSuccess(data: result.scales);
    } else if (result.error.exists) {
      value = AppStateError(message: result.error?.message ?? 'Erro ao buscar escalas médicas cadastradas');
    }
  }

  DoctorScale? getDoctorOfTheDay(List<DoctorScale> scales) {
    final currentDate = scales.firstWhereOrNull(
      (element) => element.date.toDateTime.isTheSameDay(KCurrentDate),
    );

    if (currentDate != null) {
      return currentDate;
    } else {
      DoctorScale recentScale = scales.first;

      for (var scale in scales) {
        if (scale.date.toDateTime.isAfter(recentScale.date.toDateTime) &&
            scale.date.toDateTime.isBefore(KCurrentDate)) {
          recentScale = scale;
        }
      }

      return recentScale;
    }
  }
}
