import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/model/address_model.dart';
import '../../domain/model/patient_model.dart';
import '../forms/inputs.dart';
import '../forms/new_patient_form.dart';

@singleton
class NewPatientFormController {
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
  final ValueNotifier<NewPatinetForm> form = ValueNotifier(NewPatinetForm());

  // Value Notifiers
  final ValueNotifier<List<String>> ilnesses = ValueNotifier([]);
  final ValueNotifier<String> selectedGender = ValueNotifier('');
  final ValueNotifier<bool> showIlnessField = ValueNotifier(false);
  final ValueNotifier<PatientModel> newPatient = ValueNotifier(const PatientModel.initial());

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

  PatientModel updatePatient() {
    newPatient.value = newPatient.value.copyWith(
      name: nameCt.text,
      age: ageCt.text,
      gender: genderCt.text,
      phone: phoneCt.text,
      familyGroup: 'A definir',
      address: AddressModel(
        city: cityCt.text,
        street: streetCt.text,
        neighborhood: neighCt.text,
        number: numberCt.text,
        state: 'RN',
      ),
      previousIlnesses: ilnesses.value,
    );
    return newPatient.value;
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
    form.value = NewPatinetForm();
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
}
