import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/core/services/firestore/firestore_collections.dart';

import '../../../../../core/error/app_error.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../core/services/firestore/firestore_service.dart';

import '../../../../../core/services/logger.dart';
import '../../domain/model/patient_model.dart';
import '../types/home_types.dart';

abstract class GetPatientsRepository {
  GetPatientsOrError getPatients();
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
}
