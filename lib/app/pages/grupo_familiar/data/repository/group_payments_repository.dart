import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/services/firestore/firestore_collections.dart';

import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../../../../common/services/logger.dart';
import '../../../../../common/types/types.dart';
import '../../../../../core/helps/map_utils.dart';
import '../../../../../common/services/firestore/firestore_service.dart';

import '../../domain/model/family_payment_model.dart';
import '../types.dart/group_types.dart';

abstract class GroupPaymentsRepository {
  FamilyGroupPaymentsOrError getGroupPayments({required String id});
  FamilyGroupPaymentsOrError getAllPayments();
  UnitOrError editPayment({required FamilyPaymnetModel payment});
  UnitOrError generatePayment({required FamilyPaymnetModel newPayment});
  UnitOrError deletePayment({required FamilyPaymnetModel payment});
}

@Injectable(as: GroupPaymentsRepository)
class GroupPaymentsRepositoryImpl implements GroupPaymentsRepository {
  @override
  FamilyGroupPaymentsOrError getGroupPayments({required String id}) async {
    try {
      final res =
          await FirestoreService.fire.collection(Collections.payments).where('familyGroupId', isEqualTo: id).get();

      final docs = res.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final data = docs.map((e) => FamilyPaymnetModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor, 'getGroupPayments');
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
      final docs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();
      final data = docs.map((e) => FamilyPaymnetModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor, 'getAllPayments');
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
}
