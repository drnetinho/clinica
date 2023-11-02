import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/common/services/firestore/firestore_collections.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/mixin/firebase_update_field.dart';
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
  UnitOrError addPatientAvaliation({required String avaliationId, required String patientId});
  UnitOrError replacePatientAvaliations({required List<String> avaliations, required String patientId});
}

@Injectable(as: GetPatientsRepository)
class GetPatientsRepositoryImpl with UpdateFirebaseDocField implements GetPatientsRepository {
  final idKey = 'id';
  @override
  GetPatientsOrError getPatients() async {
    try {
      final response = await FirestoreService.fire.collection(Collections.patients).get();
      final docs = response.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.patients, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();

      final data = docs.map((e) => PatientModel.fromJson(e)).toList();

      Logger.prettyPrint('LISTA DE PACIENTES', Logger.greenColor, 'getPatients');

      return (error: null, patients: data);
    } on FirebaseException {
      return (error: RemoteError(), patients: null);
    } catch (e) {
      return (error: UndefiniedError(), patients: null);
    }
  }

  @override
  UnitOrError deletePatient({required String id}) async {
    try {
      await FirestoreService.fire.collection(Collections.patients).doc(id).delete();
      Logger.prettyPrint('DELETANDO PACIENTE', Logger.redColor, 'deletePatient');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
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
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
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
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }

  @override
  UnitOrError addPatientAvaliation({
    required String avaliationId,
    required String patientId,
  }) async {
    try {
      await FirestoreService.fire.collection(Collections.patients).doc(patientId).update({'avaliations': avaliationId});

      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }

  @override
  UnitOrError replacePatientAvaliations({required List<String> avaliations, required String patientId}) async {
    try {
      await FirestoreService.fire.collection(Collections.patients).doc(patientId).set(
        {'avaliations': avaliations},
      );

      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }
}
