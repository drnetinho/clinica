import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/common/services/firestore/firestore_collections.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/types/types.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../common/services/firestore/firestore_service.dart';

import '../../../../../common/services/logger.dart';
import '../types.dart/group_types.dart';

abstract class GetGroupsRepository {
  UnitOrError updateId({required String id});
  FamilyGroupsOrError getGroups();
  FamilyGroupMembersOrError getGroupMembers({required List<String> ids});
}

@Injectable(as: GetGroupsRepository)
class GetGroupsRepositoryImpl implements GetGroupsRepository {
  final FirestoreService service;

  GetGroupsRepositoryImpl({required this.service});

  @override
  FamilyGroupsOrError getGroups() async {
    try {
      final response = await FirestoreService.fire.collection(AppCollections.groups).get();
      const String key = "id";

      final docs = response.docs.map((e) {
        Map<String, dynamic> data = e.data();
        // Add MapId and update it in Firebase
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

  @override
  FamilyGroupMembersOrError getGroupMembers({required List<String> ids}) async {
    try {
      final response = await FirestoreService.fire.collection(AppCollections.patients).where('id', whereIn: ids).get();
      final docs = response.docs.map((e) => e.data()).toList();
      final data = docs.map((e) => PatientModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor);

      return (error: null, members: data);
    } on FirebaseException {
      return (error: RemoteError(), members: null);
    }
  }

  @override
  UnitOrError updateId({required String id}) async {
    try {
      await FirestoreService.fire.collection(AppCollections.groups).doc(id).update({"id": id});
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: DomainError(), unit: null);
    }
  }
}
