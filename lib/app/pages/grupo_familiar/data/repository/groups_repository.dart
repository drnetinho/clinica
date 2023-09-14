import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/common/services/firestore/firestore_collections.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/services/logger.dart';
import '../../../../../common/types/types.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../common/services/firestore/firestore_service.dart';

import '../types.dart/group_types.dart';

abstract class GroupsRepository {
  UnitOrError updateId({required String collection, required String id});
  FamilyGroupsOrError getGroups();
  FamilyGroupMembersOrError getGroupMembers({required List<String> ids});
  UnitOrError deleteGroup({required FamilyGroupModel group});
  UnitOrError generateGroup({required FamilyGroupModel group});

  UnitOrError removePatientGroup({required String patientId});
  UnitOrError addPatientGroup({required String patientId, required String groupId});
}

@Injectable(as: GroupsRepository)
class GroupsRepositoryImpl implements GroupsRepository {
  @override
  FamilyGroupsOrError getGroups() async {
    try {
      final response = await FirestoreService.fire.collection(Collections.groups).get();
      final docs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final data = docs.map((e) => FamilyGroupModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor, 'getGroups');
      return (error: null, groups: data);
    } on FirebaseException {
      return (error: RemoteError(), groups: null);
    }
  }

  @override
  FamilyGroupMembersOrError getGroupMembers({required List<String> ids}) async {
    try {
      final response = await FirestoreService.fire.collection(Collections.patients).where('id', whereIn: ids).get();
      final docs = response.docs.map((e) => e.data()).toList();
      final data = docs.map((e) => PatientModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor, 'getGroupMembers');
      return (error: null, members: data);
    } on FirebaseException {
      return (error: RemoteError(), members: null);
    } catch (e) {
      return (error: RemoteError(), members: null);
    }
  }

  @override
  UnitOrError deleteGroup({required FamilyGroupModel group}) async {
    try {
      await FirestoreService.fire.collection(Collections.groups).doc(group.id).delete();
      for (var patient in group.members) {
        await removePatientGroup(patientId: patient);
      }
      Logger.prettyPrint(group, Logger.greenColor, 'deleteGroup');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: DomainError(), unit: null);
    }
  }

  @override
  UnitOrError generateGroup({required FamilyGroupModel group}) async {
    try {
      final data = await FirestoreService.fire.collection(Collections.groups).add(group.toJson());
      for (var patient in group.members) {
        await addPatientGroup(patientId: patient, groupId: data.id);
      }
      updateId(collection: Collections.groups, id: data.id);
      Logger.prettyPrint(group, Logger.greenColor, 'generateGroup');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: DomainError(), unit: null);
    }
  }

  @override
  UnitOrError removePatientGroup({required String patientId}) async {
    try {
      await FirestoreService.fire.collection(Collections.patients).doc(patientId).update({'familyGroup': 'A definir'});
      Logger.prettyPrint(patientId, Logger.greenColor, 'removePatientGroup');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  UnitOrError addPatientGroup({required String patientId, required String groupId}) async {
    try {
      await FirestoreService.fire.collection(Collections.patients).doc(patientId).update({'familyGroup': groupId});
      Logger.prettyPrint(patientId, Logger.greenColor, 'addPatientGroup');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  UnitOrError updateId({required String collection, required String id}) async {
    try {
      await FirestoreService.fire.collection(collection).doc(id).update({"id": id});
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: DomainError(), unit: null);
    }
  }
}
