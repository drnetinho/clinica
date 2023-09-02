import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/app_error.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../core/services/firestore/firestore_service.dart';

import '../../../../../core/services/logger.dart';
import '../../domain/model/patient_model.dart';
import '../types/home_types.dart';

abstract class GetCitiesRepository {
  GetCitiesOrError getPatients();
}

@Injectable(as: GetCitiesRepository)
class GetCitiesRepositoryImpl implements GetCitiesRepository {
  final FirestoreService service;

  GetCitiesRepositoryImpl({
    required this.service,
  });

  @override
  GetCitiesOrError getPatients() async {
    try {
      final response = await FirestoreService.fire.collection('cities').get();

      final docs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();

      final data = docs.map((e) => PatientModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor);

      return (error: null, cities: data);
    } on FirebaseException {
      return (error: RemoteError(), cities: null);
    }
  }
}
