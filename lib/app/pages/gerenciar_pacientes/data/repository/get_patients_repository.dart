import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
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
  UnitOrError updateId({required String id});

  Future<({AppError? error, List<FamilyGroupModel>? groups})> getGroups();
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
      final response = await FirestoreService.fire.collection(AppCollections.patients).get();
      const String key = "id";

      final docs = response.docs.map((e) {
        Map<String, dynamic> data = e.data();
        if (data.containsKey(key) && data[key].isEmpty) {
          data = addMapId(data, e.id);
          updateId(id: e.id);
        } else if (!data.containsKey(key)) {
          data = addMapId(data, e.id);
          updateId(id: e.id);
        }
        return data;
      }).toList();

      final data = docs.map((e) => PatientModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor);

      return (error: null, patients: data);
    } on FirebaseException {
      return (error: RemoteError(), patients: null);
    }
  }

  @override
  UnitOrError deletePatient({required String id}) async {
    try {
      await FirestoreService.fire.collection(AppCollections.patients).doc(id).delete();
      Logger.prettyPrint(id, Logger.redColor);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  UnitOrError addPatient({required PatientModel patient}) async {
    try {
      await FirestoreService.fire.collection(AppCollections.patients).add(patient.toJson());
      Logger.prettyPrint(patient, Logger.cyanColor);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  UnitOrError updatePatient({required PatientModel patient}) async {
    try {
      await FirestoreService.fire.collection(AppCollections.patients).doc(patient.id).update(patient.toJson());
      Logger.prettyPrint(patient, Logger.greenColor);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  UnitOrError updateId({required String id}) async {
    try {
      await FirestoreService.fire.collection(AppCollections.patients).doc(id).update({"id": id});
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  Future<({AppError? error, List<FamilyGroupModel>? groups})> getGroups() async {
    try {
      final response = await FirestoreService.fire.collection(AppCollections.patients).get();

      const String key = "id";

      final docs = response.docs.map((e) {
        Map<String, dynamic> data = e.data();
        if (data.containsKey(key) && data[key].isEmpty) {
          data = addMapId(data, e.id);
          updateId(id: e.id);
        } else if (!data.containsKey(key)) {
          data = addMapId(data, e.id);
          updateId(id: e.id);
        }
        return data;
      }).toList();

      final data = docs.map((e) {
        return FamilyGroupModel.fromJson(e);
      }).toList();
      Logger.prettyPrint(data, Logger.greenColor);

      return (error: null, groups: data);
    } on FirebaseException {
      return (error: RemoteError(), groups: null);
    }
  }
}
