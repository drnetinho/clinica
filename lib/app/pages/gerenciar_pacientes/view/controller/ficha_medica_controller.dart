import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/forms/ficha_medica_form.dart';
import 'package:netinhoappclinica/common/form/inputs.dart';
import 'package:netinhoappclinica/common/model/address_model.dart';

@injectable
class FichaMedicaController {
  // Controllers
  final TextEditingController nameCt = TextEditingController();
  final TextEditingController ageCt = TextEditingController();
  final TextEditingController genderCt = TextEditingController();
  final TextEditingController phoneCt = TextEditingController();
  final TextEditingController cityCt = TextEditingController();
  final TextEditingController streetCt = TextEditingController();
  final TextEditingController neighCt = TextEditingController();
  final TextEditingController numberCt = TextEditingController();
  final TextEditingController ilnessCt = TextEditingController();

  // Form
  final ValueNotifier<FichaMedicaForm> form = ValueNotifier(FichaMedicaForm());

  // Value Notifiers
  final ValueNotifier<List<String>> ilnesses = ValueNotifier([]);
  final ValueNotifier<String> selectedGender = ValueNotifier('');
  final ValueNotifier<bool> showIlnessField = ValueNotifier(false);
  final ValueNotifier<PatientModel> patientEdited = ValueNotifier(const PatientModel.initial());

  set addIlness(String ilness) => ilnesses.value = [...ilnesses.value, ilness];

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
    ilnesses.value = patient.previousIlnesses ?? [];
    // Controllers
    nameCt.text = patient.name;
    ageCt.text = patient.age;
    genderCt.text = patient.gender;
    phoneCt.text = patient.phone;
    cityCt.text = patient.address?.city ?? '';
    streetCt.text = patient.address?.street ?? '';
    neighCt.text = patient.address?.neighborhood ?? '';
    numberCt.text = patient.address?.number ?? '';
  }

  PatientModel updatePatient() {
    patientEdited.value = patientEdited.value.copyWith(
      name: nameCt.text,
      age: ageCt.text,
      gender: genderCt.text,
      phone: phoneCt.text,
      address: AddressModel(
        city: cityCt.text,
        street: streetCt.text,
        neighborhood: neighCt.text,
        number: numberCt.text,
        state: 'RN',
      ),
      previousIlnesses: ilnesses.value,
    );
    return patientEdited.value;
  }

  void setFormListeners() {
    nameCt.addListener(() => form.value = form.value.copyWith(name: StringInput.dirty(nameCt.text)));
    ageCt.addListener(() => form.value = form.value.copyWith(age: StringInput.dirty(ageCt.text)));
    phoneCt.addListener(() => form.value = form.value.copyWith(phone: PhoneInput.dirty(phoneCt.text)));
    cityCt.addListener(() => form.value = form.value.copyWith(city: StringInput.dirty(cityCt.text)));
    streetCt.addListener(() => form.value = form.value.copyWith(street: StringInput.dirty(streetCt.text)));
    neighCt.addListener(() => form.value = form.value.copyWith(neighborhood: StringInput.dirty(neighCt.text)));
    numberCt.addListener(() => form.value = form.value.copyWith(number: StringInput.dirty(numberCt.text)));
    ilnessCt.addListener(() => form.value = form.value.copyWith(ilness: StringInput.dirty(ilnessCt.text)));
  }

  void resetValues() {
    nameCt.clear();
    ageCt.clear();
    genderCt.clear();
    phoneCt.clear();
    cityCt.clear();
    streetCt.clear();
    neighCt.clear();
    numberCt.clear();
    ilnessCt.clear();
    ilnesses.value.clear();
    selectedGender.value = '';
  }
}
