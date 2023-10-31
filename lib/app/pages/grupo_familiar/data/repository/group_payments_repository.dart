import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/common/services/firestore/firestore_collections.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/mixin/firebase_update_field.dart';
import '../../../../../common/services/logger.dart';
import '../../../../../common/types/types.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../common/services/firestore/firestore_service.dart';

import '../../domain/model/family_payment_model.dart';
import '../types/group_types.dart';

abstract class GroupPaymentsRepository {
  FamilyGroupPaymentsOrError getGroupPayments({required String id});
  FamilyGroupPaymentsOrError getAllPayments();
  FamilyGroupPaymentsOrError getAllPendingPayments();
  UnitOrError editPayment({required FamilyPaymnetModel payment});
  UnitOrError generatePayment({required FamilyPaymnetModel newPayment});
  UnitOrError deletePayment({required FamilyPaymnetModel payment});
}

@Injectable(as: GroupPaymentsRepository)
class GroupPaymentsRepositoryImpl with UpdateFirebaseDocField implements GroupPaymentsRepository {
  final idKey = 'id';
  @override
  FamilyGroupPaymentsOrError getGroupPayments({required String id}) async {
    try {
      final res =
          await FirestoreService.fire.collection(Collections.payments).where('familyGroupId', isEqualTo: id).get();

      final docs = res.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.payments, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();
      final data = docs.map((e) => FamilyPaymnetModel.fromJson(e)).toList();
      Logger.prettyPrint('LISTA DE PAGAMENTOS', Logger.greenColor, 'getGroupPayments');
      data.sort((a, b) => b.payDate.compareTo(a.payDate));
      return (error: null, payments: data);
    } on FirebaseException {
      return (error: RemoteError(), payments: null);
    } catch (e) {
      return (error: UndefiniedError(), payments: null);
    }
  }

  @override
  FamilyGroupPaymentsOrError getAllPayments() async {
    try {
      final response = await FirestoreService.fire.collection(Collections.payments).get();
      final docs = response.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.payments, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();
      final data = docs.map((e) => FamilyPaymnetModel.fromJson(e)).toList();
      Logger.prettyPrint('', Logger.greenColor, 'getAllPayments');
      return (error: null, payments: data);
    } on FirebaseException {
      return (error: RemoteError(), payments: null);
    } catch (e) {
      return (error: UndefiniedError(), payments: null);
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
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
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
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }

  @override
  UnitOrError deletePayment({required FamilyPaymnetModel payment}) async {
    try {
      await FirestoreService.fire.collection(Collections.payments).doc(payment.id).delete();
      Logger.prettyPrint(payment, Logger.greenColor, 'deletePayment');
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }

  @override
  FamilyGroupPaymentsOrError getAllPendingPayments() async {
    try {
      final response =
          await FirestoreService.fire.collection(Collections.payments).where('pending', isEqualTo: true).get();
      final docs = response.docs.map((e) {
        if (mapContainsEmptyKey(e.data(), idKey)) {
          updateField(collection: Collections.payments, docId: e.id, map: {idKey: e.id});
        }
        return addMapId(e.data(), e.id);
      }).toList();
      final data = docs.map((e) => FamilyPaymnetModel.fromJson(e)).toList();
      Logger.prettyPrint('LISTA DE PAGAMENTOS PENDENTES', Logger.greenColor, 'getAllPendingPayments');
      return (error: null, payments: data);
    } on FirebaseException {
      return (error: RemoteError(), payments: null);
    } catch (e) {
      return (error: UndefiniedError(), payments: null);
    }
  }
}
