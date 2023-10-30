import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/helps/actual_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewAvaliationController {
  // Text Editing Controllers
  final obsCtrl = TextEditingController();
  final pressaoArterialCtrl = TextEditingController();
  final pesoCtrl = TextEditingController();
  final freqCardiacaCtrl = TextEditingController();
  final freqRespiratoriaCtrl = TextEditingController();

  // Others
  final ValueNotifier<Doctor> doctor = ValueNotifier(Doctor.empty());
  final ValueNotifier<List<String>> exames = ValueNotifier([]);
  final ValueNotifier<PatientModel> patient = ValueNotifier(
    PatientModel.initial(
      createdAt: KCurrentDate,
    ),
  );

  void resetAllFields() {
    obsCtrl.clear();
    pressaoArterialCtrl.clear();
    pesoCtrl.clear();
    freqCardiacaCtrl.clear();
    freqRespiratoriaCtrl.clear();
    doctor.value = Doctor.empty();
    exames.value = [];
    patient.value = PatientModel.initial(
      createdAt: KCurrentDate,
    );
  }

  void dispose() {
    obsCtrl.dispose();
    pressaoArterialCtrl.dispose();
    pesoCtrl.dispose();
    freqCardiacaCtrl.dispose();
    freqRespiratoriaCtrl.dispose();
    doctor.dispose();
    exames.dispose();
    patient.dispose();
  }
}
