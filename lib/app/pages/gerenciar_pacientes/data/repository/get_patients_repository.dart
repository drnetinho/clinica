import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/services/firestore/firestore_collections.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/types/types.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../common/services/firestore/firestore_service.dart';

import '../../../../../common/services/logger.dart';
import '../../domain/model/patient_model.dart';
import '../types/home_types.dart';

abstract class GetPatientsRepository {
  GetPatientsOrError getPatients();
  UnitOrError deletePatient({required String id});
  UnitOrError addPatient({required PatientModel patient});
  UnitOrError updatePatient({required PatientModel patient});
}

@Injectable(as: GetPatientsRepository)
class GetPatientsRepositoryImpl implements GetPatientsRepository {
  @override
  GetPatientsOrError getPatients() async {
    try {
      final response = await FirestoreService.fire.collection(Collections.patients).get();
      final docs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final data = docs.map((e) => PatientModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor, 'getPatients');
      return (error: null, patients: data);
    } on FirebaseException {
      return (error: RemoteError(), patients: null);
    }
  }

  @override
  UnitOrError deletePatient({required String id}) async {
    try {
      await FirestoreService.fire.collection(Collections.patients).doc(id).delete();
      Logger.prettyPrint(id, Logger.redColor, 'deletePatient');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  UnitOrError addPatient({required PatientModel patient}) async {
    try {
      await FirestoreService.fire.collection(Collections.patients).add(patient.toJson());
      Logger.prettyPrint(patient, Logger.cyanColor, 'addPatient');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  UnitOrError updatePatient({required PatientModel patient}) async {
    try {
      await FirestoreService.fire.collection(Collections.patients).doc(patient.id).update(patient.toJson());
      Logger.prettyPrint(patient, Logger.greenColor, 'updatePatient');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }
  


}
