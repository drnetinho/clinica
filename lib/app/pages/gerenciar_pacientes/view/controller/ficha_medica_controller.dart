import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/view/forms/ficha_medica_form.dart';
import 'package:clisp/common/form/inputs.dart';
import 'package:clisp/common/model/address_model.dart';
import 'package:clisp/core/helps/actual_date.dart';

@injectable
class FichaMedicaController {
  final nameCt = TextEditingController();
  final ageCt = TextEditingController();
  final cpfCt = TextEditingController();
  final genderCt = TextEditingController();
  final phoneCt = TextEditingController();
  final cityCt = TextEditingController();
  final streetCt = TextEditingController();
  final neighCt = TextEditingController();
  final numberCt = TextEditingController();
  final ilnessCt = TextEditingController();

  // Form
  final ValueNotifier<FichaMedicaForm> form = ValueNotifier(FichaMedicaForm());

  // Value Notifiers
  final ValueNotifier<List<String>> ilnesses = ValueNotifier([]);
  final ValueNotifier<String> selectedGender = ValueNotifier('');
  final ValueNotifier<bool> showIlnessField = ValueNotifier(false);
  final ValueNotifier<PatientModel> patientEdited = ValueNotifier(PatientModel.initial(
    createdAt: KCurrentDate,
  ));

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
    ilnesses.value = patient.previousIlnesses != null ? [...patient.previousIlnesses!] : [];
    // Controllers
    nameCt.text = patient.name;
    ageCt.text = patient.age;
    genderCt.text = patient.gender;
    phoneCt.text = patient.phone;
    cityCt.text = patient.address?.city ?? '';
    streetCt.text = patient.address?.street ?? '';
    neighCt.text = patient.address?.neighborhood ?? '';
    numberCt.text = patient.address?.number ?? '';
    cpfCt.text = patient.cpf;
  }

  PatientModel updatePatient() {
    patientEdited.value = patientEdited.value.copyWith(
      name: nameCt.text,
      age: ageCt.text,
      gender: genderCt.text,
      phone: phoneCt.text,
      cpf: cpfCt.text,
      address: AddressModel(
        city: cityCt.text,
        street: streetCt.text,
        neighborhood: neighCt.text,
        number: numberCt.text,
        state: 'RN',
      ),
      previousIlnesses: ilnesses.value,
      createdAt: KCurrentDate,
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
    ilnessCt.addListener(() => form.value = form.value.copyWith(ilness: EmtpyInput.dirty(ilnessCt.text)));
    cpfCt.addListener(() => form.value = form.value.copyWith(cpf: CpfInput.dirty(cpfCt.text)));
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
    cpfCt.clear();
    ilnesses.value.clear();
    selectedGender.value = '';
  }
}
