import 'package:clisp/app/pages/avaliacoes/domain/model/avaliation.dart';
import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/helps/extension/value_notifier_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/form/inputs.dart';
import '../form/new_avaliation_form.dart';

@injectable
class NewAvaliationController {
  // Text Editing Controllers
  final obsCtrl = TextEditingController();
  final pressaoArterialCtrl = TextEditingController();
  final pesoCtrl = TextEditingController();
  final freqCardiacaCtrl = TextEditingController();
  final freqRespiratoriaCtrl = TextEditingController();
  final alturaCtrl = TextEditingController();

  // Others fields
  final ValueNotifier<Doctor?> doctor = ValueNotifier(null);
  final ValueNotifier<List<String>> exames = ValueNotifier([]);
  final ValueNotifier<PatientModel?> patient = ValueNotifier(null);
  final ValueNotifier<bool> isNormal = ValueNotifier(true);

  // FORM
  final ValueNotifier<NewAvaliationForm> form = ValueNotifier(NewAvaliationForm());

  Avaliation get avaliation {
    return Avaliation(
      id: '',
      alterado: !isNormal.value,
      data: DateTime.now().toIso8601String(),
      doctorId: doctor.value?.id ?? '',
      patientId: patient.value?.id ?? '',
      altura: alturaCtrl.text,
      peso: pesoCtrl.text,
      frequenciaCardiaca: freqCardiacaCtrl.text,
      frequenciaRespiratoria: freqRespiratoriaCtrl.text,
      observacoes: obsCtrl.text,
      pressaoArterial: pressaoArterialCtrl.text,
      examesSolicitados: exames.value,
    );
  }

  void addExame(String exame) => exames.value = [...exames.value, exame];

  void removeExame(String exame) => exames.value = exames.value.where((e) => e != exame).toList();

  bool get isValidForm {
    isValid.value = form.value.isValid && doctor.exists && patient.exists;
    return isValid.value;
  }

  // Functions and utils
  final ValueNotifier<bool> isValid = ValueNotifier(false);

  void listenToForm() {
    pressaoArterialCtrl.addListener(
      () => form.value = form.value.copyWith(
        pressaoArterial: EmtpyInput.dirty(pressaoArterialCtrl.text),
      ),
    );
    pesoCtrl.addListener(
      () => form.value = form.value.copyWith(
        peso: EmtpyInput.dirty(pesoCtrl.text),
      ),
    );
    freqCardiacaCtrl.addListener(
      () => form.value = form.value.copyWith(
        frequenciaCardiaca: EmtpyInput.dirty(freqCardiacaCtrl.text),
      ),
    );
    freqRespiratoriaCtrl.addListener(
      () => form.value = form.value.copyWith(
        frequenciaRespiratoria: EmtpyInput.dirty(freqRespiratoriaCtrl.text),
      ),
    );
    alturaCtrl.addListener(
      () => form.value = form.value.copyWith(
        altura: EmtpyInput.dirty(alturaCtrl.text),
      ),
    );
    obsCtrl.addListener(
      () => form.value = form.value.copyWith(
        obs: EmtpyInput.dirty(obsCtrl.text),
      ),
    );
  }

  void resetAllFields() {
    obsCtrl.clear();
    pressaoArterialCtrl.clear();
    pesoCtrl.clear();
    freqCardiacaCtrl.clear();
    freqRespiratoriaCtrl.clear();
    alturaCtrl.clear();
    doctor.value = null;
    patient.value = null;
    exames.value = [];
    isNormal.value = true;
    form.value = NewAvaliationForm();
  }

  void dispose() {
    obsCtrl.dispose();
    pressaoArterialCtrl.dispose();
    pesoCtrl.dispose();
    freqCardiacaCtrl.dispose();
    freqRespiratoriaCtrl.dispose();
    alturaCtrl.dispose();
    doctor.dispose();
    exames.dispose();
    patient.dispose();
    isNormal.dispose();
    form.dispose();
  }

  void setupFields({
    required Avaliation avaliation,
    required Doctor doctor,
    required PatientModel patient,
  }) {
    obsCtrl.text = avaliation.observacoes ?? '';
    pressaoArterialCtrl.text = avaliation.pressaoArterial ?? '';
    pesoCtrl.text = avaliation.peso ?? '';
    freqCardiacaCtrl.text = avaliation.frequenciaCardiaca ?? '';
    freqRespiratoriaCtrl.text = avaliation.frequenciaRespiratoria ?? '';
    alturaCtrl.text = avaliation.altura ?? '';
    this.doctor.value = doctor;
    this.patient.value = patient;
    exames.value = avaliation.examesSolicitados ?? [];
    isNormal.value = !avaliation.alterado;
  }
}
