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

import '../../domain/model/family_payment_model.dart';
import '../types.dart/group_types.dart';

abstract class GetGroupsRepository {
  UnitOrError updateId({required String collection, required String id});
  FamilyGroupsOrError getGroups();
  FamilyGroupMembersOrError getGroupMembers({required List<String> ids});
  FamilyGroupPaymentsOrError getGroupPayments({required String id});
  FamilyGroupPaymentsOrError getAllPayments();
  UnitOrError editPayment({required FamilyPaymnetModel payment});
  UnitOrError generatePayment({required FamilyPaymnetModel newPayment});
}

@Injectable(as: GetGroupsRepository)
class GetGroupsRepositoryImpl implements GetGroupsRepository {
  final String key = "id";
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
    }
  }

  @override
  FamilyGroupPaymentsOrError getGroupPayments({required String id}) async {
    try {
      final res =
          await FirestoreService.fire.collection(Collections.payments).where('familyGroupId', isEqualTo: id).get();

      final docs = res.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final data = docs.map((e) => FamilyPaymnetModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor, 'getGroupPayments');
      return (error: null, payments: data);
    } on FirebaseException {
      return (error: RemoteError(), payments: null);
    }
  }

  @override
  FamilyGroupPaymentsOrError getAllPayments() async {
    try {
      final response = await FirestoreService.fire.collection(Collections.payments).get();
      final docs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final data = docs.map((e) => FamilyPaymnetModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor, 'getAllPayments');
      return (error: null, payments: data);
    } on FirebaseException {
      return (error: RemoteError(), payments: null);
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

  @override
  UnitOrError editPayment({required FamilyPaymnetModel payment}) async {
    try {
      await FirestoreService.fire.collection(Collections.payments).doc(payment.id).update(payment.toJson());
      Logger.prettyPrint(payment, Logger.greenColor, 'editPayment');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }

  @override
  UnitOrError generatePayment({required FamilyPaymnetModel newPayment}) async {
    try {
      await FirestoreService.fire.collection(Collections.payments).add(newPayment.toJson());
      Logger.prettyPrint(newPayment, Logger.greenColor, 'generateNextPayment');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }
}
