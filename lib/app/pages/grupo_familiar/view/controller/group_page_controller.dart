import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';

import '../../../gerenciar_pacientes/domain/model/patient_model.dart';

@singleton
class GroupPageController {
// Utils
  final ValueNotifier<FamilyGroupModel?> groupSelected = ValueNotifier(null);

  final ValueNotifier<bool> addNewPatient = ValueNotifier(false);
  set toogleAddNewPatient(bool value) => addNewPatient.value = value;

  // Search Mode
  final TextEditingController searchCt = TextEditingController();

  final ValueNotifier<List<PatientModel>?> searchPatients = ValueNotifier(null);
  set addSearchPatients(List<PatientModel> patients) => searchPatients.value = [...patients];
  void resetSearchPatients() => searchPatients.value = null;

  final ValueNotifier<List<FamilyGroupModel>?> searchGroups = ValueNotifier(null);
  set addsearchGroups(List<FamilyGroupModel> groups) => searchGroups.value = [...groups];
  void resetSearchGroups() => searchGroups.value = null;

  void clearCompleteSearch() {
    searchCt.clear();
    resetSearchGroups();
    resetSearchPatients();
  }

  
}
