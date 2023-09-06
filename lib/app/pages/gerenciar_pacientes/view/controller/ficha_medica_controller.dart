import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';

@singleton
class FichaMedicaController {
  final TextEditingController searchCt = TextEditingController();
  final TextEditingController nameCt = TextEditingController();
  final TextEditingController ageCt = TextEditingController();
  final TextEditingController genderCt = TextEditingController();
  final TextEditingController phoneCt = TextEditingController();
  final TextEditingController cityCt = TextEditingController();
  final TextEditingController streetCt = TextEditingController();
  final TextEditingController neighCt = TextEditingController();
  final TextEditingController numberCt = TextEditingController();
  final TextEditingController famGroupCt = TextEditingController();
  final TextEditingController ilnessCt = TextEditingController();

  final List<String> genderList = ['Masculino', 'Feminino', 'Outro'];
  // Value Notifiers
  final ValueNotifier<List<String>> ilnesses = ValueNotifier([]);
  final ValueNotifier<List<PatientModel>?> searchPatients = ValueNotifier(null);
  final ValueNotifier<String> selectedGender = ValueNotifier('');
  final ValueNotifier<bool> showIlnessField = ValueNotifier(false);
  final ValueNotifier<PatientModel> patientEdited = ValueNotifier(const PatientModel.initial());

  set addIlness(String ilness) => ilnesses.value = [...ilnesses.value, ilness];
  set addSearchPatients(List<PatientModel> patients) => searchPatients.value =  [...patients];
  void resetSearch() => searchPatients.value =  null;

  set setGender(String gender) {
    selectedGender.value = gender;
    genderCt.text = selectedGender.value;
  }

  set removeIlness(String ilness) {
    ilnesses.value.remove(ilness);
    ilnesses.value = [...ilnesses.value];
  }

  void onSubmitIlness(String ilness) {
    addIlness = ilness;
    ilnessCt.clear();
    updatePatient();
  }

  void setupConfig(PatientModel patient) {
    // Patient
    patientEdited.value = patient;
    // Preselected Gender
    selectedGender.value = patient.gender;
    // Controllers
    nameCt.text = patient.name;
    ageCt.text = patient.age;
    genderCt.text = patient.gender;
    phoneCt.text = patient.phone;
    cityCt.text = patient.address?.city ?? '';
    streetCt.text = patient.address?.street ?? '';
    neighCt.text = patient.address?.neighborhood ?? '';
    numberCt.text = patient.address?.number ?? '';
    famGroupCt.text = patient.familyGroup;
  }

  PatientModel updatePatient() {
    patientEdited.value = patientEdited.value.copyWith(
      name: nameCt.text,
      age: ageCt.text,
      gender: genderCt.text,
      phone: phoneCt.text,
      familyGroup: famGroupCt.text,
      address: patientEdited.value.address?.copyWith(
        city: cityCt.text,
        street: streetCt.text,
        neighborhood: neighCt.text,
        number: numberCt.text,
      ),
      previousIlnesses: ilnesses.value,
    );
    return patientEdited.value;
  }
}
