import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

class FirestoreService<T> {
  final FirebaseFirestore _firestore;

  FirestoreService._(this._firestore);

  static final FirestoreService instance = FirestoreService._(
    FirebaseFirestore.instance,
  );

  static final FirebaseFirestore fire = instance._firestore;
}

@module
abstract class FirestoreModule {
  FirestoreService get firestoreService => FirestoreService.instance;
}
