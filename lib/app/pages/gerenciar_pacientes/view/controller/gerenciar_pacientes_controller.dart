import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/patient_model.dart';

@singleton
class GerenciarPacientesController {
  // Utils
  final List<String> genderList = ['Masculino', 'Feminino', 'Outro'];
  final ValueNotifier<PatientModel?> patientSelected = ValueNotifier(null);

  final ValueNotifier<bool> addNewPatient = ValueNotifier(false);
  set toogleAddNewPatient(bool value) => addNewPatient.value = value;

  // Search Mode
  final TextEditingController searchCt = TextEditingController();
  final ValueNotifier<List<PatientModel>?> searchPatients = ValueNotifier(null);

  set addSearchPatients(List<PatientModel> patients) => searchPatients.value = [...patients];
  void resetSearch() {
    searchPatients.value = null;
    searchCt.clear();
  }
  void resetPatient() {
    patientSelected.value = null;
  }
}
