import 'package:firebase_core/firebase_core.dart';

import '../either/either.dart';
import '../error/app_error.dart';
import '../services/firestore/firestore_service.dart';
import '../types/types.dart';

mixin UpdateFirebaseDocField {
  UnitOrError updateField(
      {required String collection, required Map<String, dynamic> map, required String docId}) async {
    try {
      await FirestoreService.fire.collection(collection).doc(docId).update(map);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: DomainError(), unit: null);
    } catch (e) {
      return (error: UndefiniedError(), unit: null);
    }
  }
}
