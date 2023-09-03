import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';

@injectable
class FichaMedicaController {
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

  void updateControllers(PatientModel patient) {
    nameCt.text = patient.name;
    ageCt.text = patient.age;
    genderCt.text = patient.gender;
    phoneCt.text = patient.phone;
    cityCt.text = patient.address?.city ?? '';
    streetCt.text = patient.address?.street ?? '';
    neighCt.text = patient.address?.neighborhood ?? '';
    numberCt.text = patient.address?.number ?? '';
    famGroupCt.text = patient.familyGroup;
    ilnessCt.text = patient.previousIlnesses?.first ?? '';
  }

  PatientModel updatePatient(PatientModel patient) {
    return patient.copyWith(
      name: nameCt.text,
      age: ageCt.text,
      gender: genderCt.text,
      phone: phoneCt.text,
      familyGroup: famGroupCt.text,
      address: patient.address?.copyWith(
        city: cityCt.text,
        street: streetCt.text,
        neighborhood: neighCt.text,
        number: numberCt.text,
      ),
      previousIlnesses: [ilnessCt.text],
    );
  }
}
