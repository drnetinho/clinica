import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/doctors/domain/model/doctor.dart';
import 'package:netinhoappclinica/common/services/firestore/firestore_collections.dart';
import 'package:netinhoappclinica/common/types/types.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/mixin/firebase_update_field.dart';
import '../../../../../common/services/firestore/firestore_service.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../scale/data/repository/scale_repository.dart';
import '../types/doctors_types.dart';

abstract class DoctorRepository {
  DoctorsOrError getDoctors();
  UnitOrError editDoctor({required Doctor doctor});
  UnitOrError deleteDoctor({required String id});
  UnitOrError addDoctor({required Doctor doctor});
}

@Injectable(as: DoctorRepository)
class DoctorRepositoryImpl with UpdateFirebaseDocField implements DoctorRepository {
  final ScaleRepository _scaleRepository;

  DoctorRepositoryImpl(this._scaleRepository);
  final idKey = 'id';

  @override
  DoctorsOrError getDoctors() async {
    try {
      final res = await FirestoreService.fire.collection(Collections.doctors).get();
      final docs = res.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.doctors, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();
      final data = docs.map((e) => Doctor.fromJson(e)).toList();
      return (error: null, doctors: data);
    } on FirebaseException {
      return (error: DomainError(), doctors: null);
    } catch (e) {
      return (error: UndefiniedError(), doctors: null);
    }
  }

  @override
  UnitOrError deleteDoctor({required String id}) async {
    try {
      await FirestoreService.fire.collection(Collections.doctors).doc(id).delete();
      await _scaleRepository.deleteScalesFromDoctorId(doctorId: id);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }

  @override
  UnitOrError editDoctor({required Doctor doctor}) async {
    try {
      await FirestoreService.fire.collection(Collections.doctors).doc(doctor.id).update(doctor.toJson());
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }

  @override
  UnitOrError addDoctor({required Doctor doctor}) async {
    try {
      await FirestoreService.fire.collection(Collections.doctors).add(doctor.toJson());
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: null, unit: unit);
    } catch (e) {
      return (error: null, unit: unit);
    }
  }
}
