import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/services/firestore/firestore_collections.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../common/services/firestore/firestore_service.dart';

import '../../../../../common/services/logger.dart';
import '../../domain/model/patient_model.dart';
import '../types/home_types.dart';

abstract class GetPatientsRepository {
  GetPatientsOrError getPatients();
  DeletePatientOrError deletePatient({required String id});
  AddPatientOrError addPatient({required PatientModel patient});
}

@Injectable(as: GetPatientsRepository)
class GetPatientsRepositoryImpl implements GetPatientsRepository {
  final FirestoreService service;

  GetPatientsRepositoryImpl({
    required this.service,
  });

  @override
  GetPatientsOrError getPatients() async {
    try {
      final response = await FirestoreService.fire.collection(FirestoreCollections.patients).get();

      final docs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();

      final data = docs.map((e) => PatientModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor);

      return (error: null, patients: data);
    } on FirebaseException {
      return (error: RemoteError(), patients: null);
    }
  }

  @override
  DeletePatientOrError deletePatient({required String id}) async {
    try {
      await FirestoreService.fire.collection(FirestoreCollections.patients).doc(id).delete();
      Logger.prettyPrint(id, Logger.redColor);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  AddPatientOrError addPatient({required PatientModel patient}) async {
    try {
      await FirestoreService.fire.collection(FirestoreCollections.patients).add(patient.toJson());
      Logger.prettyPrint(patient, Logger.cyanColor);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }
}
