import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import 'package:clisp/common/services/firestore/firestore_collections.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/mixin/firebase_update_field.dart';
import '../../../../../common/services/logger.dart';
import '../../../../../common/types/types.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../common/services/firestore/firestore_service.dart';

import '../types/group_types.dart';

abstract class GroupsRepository {
  FamilyGroupsOrError getGroups();
  FamilyGroupOrError getGroupByCpf({required String cpf});
  FamilyGroupMembersOrError getGroupMembers({required List<String> ids});
  UnitOrError generateGroup({
    required FamilyGroupModel group,
    required FamilyPaymnetModel paymnetModel,
  });
  UnitOrError addPatientGroup({required String patientId, required String groupId});
  UnitOrError deleteGroup({required FamilyGroupModel group});
  UnitOrError removeGroupPayments({required String paymentId});
  UnitOrError removePatientGroup({required String patientId});
  UnitOrError updateGroup({
    required FamilyGroupModel group,
    required List<String> membersToRemove,
    required List<String> membersToAdd,
  });
}

@Injectable(as: GroupsRepository)
class GroupsRepositoryImpl with UpdateFirebaseDocField implements GroupsRepository {
  final idKey = 'id';
  @override
  FamilyGroupsOrError getGroups() async {
    try {
      final response = await FirestoreService.fire.collection(Collections.groups).get();

      final docs = response.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.groups, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();

      final data = docs.map((e) => FamilyGroupModel.fromJson(e)).toList();

      Logger.prettyPrint('LISTA DE GRUPOS', Logger.greenColor, 'getGroups');
      return (error: null, groups: data);
    } on FirebaseException {
      return (error: RemoteError(), groups: null);
    } catch (e) {
      return (error: UndefiniedError(), groups: null);
    }
  }

  @override
  UnitOrError updateGroup({
    required FamilyGroupModel group,
    required List<String> membersToRemove,
    required List<String> membersToAdd,
  }) async {
    try {
      // Atualizando o Grupo
      await FirestoreService.fire.collection(Collections.groups).doc(group.id).update(group.toJson());
      // Removendo o Grupo para cada paciente que não faz mais parte
      for (var member in membersToRemove) {
        await removePatientGroup(patientId: member);
      }
      // Atualizando o Grupo dos atuais pacientes
      for (var member in membersToAdd) {
        await updateField(
          collection: Collections.patients,
          docId: member,
          map: {"familyGroup": group.id},
        );
      }

      Logger.prettyPrint(group, Logger.greenColor, 'updateGroup');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }

  @override
  FamilyGroupMembersOrError getGroupMembers({required List<String> ids}) async {
    try {
      final response = await FirestoreService.fire.collection(Collections.patients).where('id', whereIn: ids).get();
      final docs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final data = docs.map((e) => PatientModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor, 'getGroupMembers');
      return (error: null, members: data);
    } on FirebaseException {
      return (error: RemoteError(), members: null);
    } catch (e) {
      return (error: UndefiniedError(), members: null);
    }
  }

  @override
  UnitOrError deleteGroup({required FamilyGroupModel group}) async {
    try {
      await FirestoreService.fire.collection(Collections.groups).doc(group.id).delete();
      for (var patient in group.members) {
        await removePatientGroup(patientId: patient);
      }
      for (var payment in group.payments) {
        await removeGroupPayments(paymentId: payment);
      }

      Logger.prettyPrint(group, Logger.greenColor, 'deleteGroup');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: DomainError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }

  @override
  UnitOrError generateGroup({
    required FamilyGroupModel group,
    required FamilyPaymnetModel paymnetModel,
  }) async {
    try {
      final newGroup = await FirestoreService.fire.collection(Collections.groups).add(group.toJson());

      // Gerando um novo pagamento para o grupo
      final newPayment = await FirestoreService.fire.collection(Collections.payments).add(
            paymnetModel.copyWith(familyGroupId: newGroup.id).toJson(),
          );

      // Atualizando os pagamentos do grupo
      await updateField(
        collection: Collections.groups,
        docId: newGroup.id,
        map: {
          "payments": [newPayment.id]
        },
      );

      // Atualizando o grupo do pagamento
      await updateField(
        collection: Collections.payments,
        docId: newPayment.id,
        map: {"familyGroupId": newGroup.id},
      );

      // Atualizando os membros do grupo
      for (var patient in group.members) {
        await addPatientGroup(patientId: patient, groupId: newGroup.id);
      }

      Logger.prettyPrint(group, Logger.greenColor, 'generateGroup');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: DomainError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
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
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
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
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }

  @override
  UnitOrError removeGroupPayments({required String paymentId}) async {
    try {
      await FirestoreService.fire.collection(Collections.payments).doc(paymentId).delete();
      Logger.prettyPrint(paymentId, Logger.greenColor, 'removeGroupPayments');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }

  @override
  FamilyGroupOrError getGroupByCpf({required String cpf}) async {
    try {
      final response = await FirestoreService.fire.collection(Collections.patients).where('cpf', isEqualTo: cpf).get();
      final patientDocs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final patient = patientDocs.map((e) => PatientModel.fromJson(e)).toList().first;

      final res =
          await FirestoreService.fire.collection(Collections.groups).where('id', isEqualTo: patient.familyGroup).get();
      final groupDocs = res.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final group = groupDocs.map((e) => FamilyGroupModel.fromJson(e)).toList().first;
      Logger.prettyPrint(group, Logger.greenColor, 'getGroupByCPF');
      return (error: null, group: group);
    } on FirebaseException {
      return (error: RemoteError(), group: null);
    } catch (e) {
      return (error: RemoteError(), group: null);
    }
  }
}
