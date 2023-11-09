// ignore_for_file: unused_local_variable, unused_field

import 'package:clisp/app/pages/avaliacoes/domain/model/avaliation.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/common/services/firestore/firestore_collections.dart';
import 'package:clisp/common/types/types.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/mixin/firebase_update_field.dart';
import '../../../../../common/services/firestore/firestore_service.dart';
import '../../../../../core/helps/map_utils.dart';
import '../types/avaliations_types.dart';

abstract class AvaliationsRepository {
  AvaliationsOrError getPatientAvaliations({required String patientId});
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
  AvaliationsOrError getPatientAvaliations({required String patientId}) async {
    try {
      final res = await FirestoreService.fire
          .collection(Collections.avaliations)
          .where('patientId', isEqualTo: patientId)
          .get();
      final docs = res.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.avaliations, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();
      final data = docs.map((e) => Avaliation.fromJson(e)).toList();
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
      await FirestoreService.fire.collection(Collections.avaliations).doc(id).delete();

      // await remover avaliação do paciente
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
      final newAvaliation = await FirestoreService.fire.collection(Collections.avaliations).add(avaliation.toJson());
      // await _patientRepository.addPatientAvaliation(avaliationId: newAvaliation.id, patientId: avaliation.patientId);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }
}
