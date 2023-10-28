import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/scale/data/types/scale_types.dart';
import 'package:netinhoappclinica/app/pages/scale/domain/model/doctor_scale.dart';
import 'package:netinhoappclinica/common/services/firestore/firestore_collections.dart';
import 'package:netinhoappclinica/common/types/types.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/mixin/firebase_update_field.dart';
import '../../../../../common/services/firestore/firestore_service.dart';
import '../../../../../core/helps/map_utils.dart';

abstract class ScaleRepository {
  DoctorScalesOrError getScales();
  UnitOrError editScale({required DoctorScale scale});
  UnitOrError deleteScale({required String id});
  UnitOrError addScale({required DoctorScale scale});
  UnitOrError deleteScalesFromDoctorId({required String doctorId});
}

@Injectable(as: ScaleRepository)
class ScaleRepositoryImpl with UpdateFirebaseDocField implements ScaleRepository {
  final idKey = 'id';

  @override
  DoctorScalesOrError getScales() async {
    try {
      final res = await FirestoreService.fire.collection(Collections.scales).get();
      final docs = res.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.scales, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();
      final data = docs.map((e) => DoctorScale.fromJson(e)).toList();
      return (error: null, scales: data);
    } on FirebaseException {
      return (error: DomainError(), scales: null);
    } catch (e) {
      return (error: UndefiniedError(), scales: null);
    }
  }

  @override
  UnitOrError deleteScale({required String id}) async {
    try {
      await FirestoreService.fire.collection(Collections.scales).doc(id).delete();
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }

  @override
  UnitOrError editScale({required DoctorScale scale}) async {
    try {
      await FirestoreService.fire.collection(Collections.scales).doc(scale.id).update(scale.toJson());
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }

  @override
  UnitOrError addScale({required DoctorScale scale}) async {
    try {
      await FirestoreService.fire.collection(Collections.scales).add(scale.toJson());
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }

  @override
  UnitOrError deleteScalesFromDoctorId({required String doctorId}) async {
    try {
      final affected =
          await FirestoreService.fire.collection(Collections.scales).where('doctorId', isEqualTo: doctorId).get();

      final docs = affected.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.scales, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();

      final data = docs.map((e) => DoctorScale.fromJson(e)).toList();

      for (var scale in data) {
        await deleteScale(id: scale.id);
      }

      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }
}
