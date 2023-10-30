import 'package:clisp/app/pages/avaliacoes/domain/model/avaliation.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/common/services/firestore/firestore_collections.dart';
import 'package:clisp/common/types/types.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/mixin/firebase_update_field.dart';
import '../../../../../common/services/firestore/firestore_service.dart';
import '../../../../../core/helps/map_utils.dart';
import '../types/avaliations_types.dart';

abstract class AvaliationsRepository {
  AvaliationsOrError getAvaliations();
  UnitOrError editAvaliation({required Avaliation avaliation});
  UnitOrError deleteAvaliation({required String id});
  UnitOrError addAvaliation({required Avaliation avaliation});
}

@Injectable(as: AvaliationsRepository)
class AvaliationsRepositoryImpl with UpdateFirebaseDocField implements AvaliationsRepository {
  final GetPatientsRepository _patientRepository;

  AvaliationsRepositoryImpl(this._patientRepository);
  final idKey = 'id';

  @override
  AvaliationsOrError getAvaliations() async {
    try {
      final res = await FirestoreService.fire.collection(Collections.doctors).get();
      final docs = res.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.doctors, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();
      final data = docs.map((e) => Doctor.fromJson(e)).toList();
      return (error: null, avaliations: data);
    } on FirebaseException {
      return (error: DomainError(), avaliations: null);
    } catch (e) {
      return (error: UndefiniedError(), avaliations: null);
    }
  }

  @override
  UnitOrError deleteAvaliation({required String id}) async {
    try {
      await FirestoreService.fire.collection(Collections.doctors).doc(id).delete();
      // TODO remover avaliacao do paciente
      // await _patientRepository.deleteScalesFromDoctorId(doctorId: id);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }

  @override
  UnitOrError editAvaliation({required Avaliation avaliation}) async {
    try {
      await FirestoreService.fire.collection(Collections.avaliations).doc(avaliation.id).update(avaliation.toJson());
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }

  @override
  UnitOrError addAvaliation({required Avaliation avaliation}) async {
    try {
      await FirestoreService.fire.collection(Collections.doctors).add(avaliation.toJson());
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }
}
