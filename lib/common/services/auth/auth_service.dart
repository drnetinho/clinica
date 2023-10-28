import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/root/routes.dart';

import '../../../app/pages/home/view/home_page.dart';
import '../../../app/pages/sigin/sign_page.dart';

@singleton
class AuthService {
  late final FirebaseAuth firebaseAuth;

  AuthService() {
    firebaseAuth = FirebaseAuth.instance;
    isLogged = ValueNotifier<bool>(currentUser != null);
    isLogged.addListener(() {
      isLogged.value ? goRouter.go(HomePage.routeName) : goRouter.go(SignPage.routeName);
    });
  }

  late final ValueNotifier<bool> isLogged;

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
      return (userCredential: null, error: 'Erro ao realizar login: ${e.code}');
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
    } finally {
      isLogged.value = false;
    }
  }
}
