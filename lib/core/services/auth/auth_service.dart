import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  late final FirebaseAuth firebaseAuth;

  AuthService() {
    firebaseAuth = FirebaseAuth.instance;
  }

  // Stream
  Stream<User?> get authState => firebaseAuth.authStateChanges();

  // Current User
  User? get currentUser => firebaseAuth.currentUser;

  // SignIn or Error
  Future<({UserCredential? userCredential, String? error})> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (userCredential: result, error: null);
    } on FirebaseAuthException catch (e) {
      log(e.message ?? '');
      return (userCredential: null, error: e.message);
    }
  }

  // SignUp or Error
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.message ?? '');
    }
  }

  // SignOut or Error
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      log(e.message ?? '');
    }
  }
}
