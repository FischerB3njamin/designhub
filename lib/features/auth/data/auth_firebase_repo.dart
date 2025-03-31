import 'package:designhub/features/auth/data/auth_repo.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebase implements AuthRepo {
  final FirebaseAuth _auth;

  AuthFirebase(this._auth);

  @override
  Stream<User?> onAuthChanged() => _auth.authStateChanges();

  @override
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credentials':
          return "Wrong logindata";
        default:
          return "An error Occured $e";
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  @override
  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return 'E-Mail already registered. Please login';
        default:
          return "An error Occured $e";
      }
    }
    return null;
  }

  @override
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on Exception catch (e) {
      return "error $e";
    }
    return null;
  }

  @override
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(error);
        print(stacktrace);
      }

      return "Ein Fehler ist aufgetreten: $error";
    }
    return null;
  }
}
