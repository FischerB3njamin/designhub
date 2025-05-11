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
        case 'invalid-email':
          return "The email address is invalid.";
        case 'user-disabled':
          return "This user account has been disabled.";
        case 'user-not-found':
          return "No user found. Please sign up.";
        case 'wrong-password':
          return "Incorrect password. Please try again.";
        case 'too-many-requests':
          return "Too many failed login attempts. Please try again later.";
        default:
          return "An unknown error occurred: ${e.message}";
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
        case 'email-already-in-use':
          return "This email address is already in use.";
        case 'invalid-email':
          return "The entered email address is invalid.";
        case 'weak-password':
          return "The password is too weak. Please choose a stronger password.";
        case 'operation-not-allowed':
          return "Registration with email and password is currently not enabled.";
        default:
          return "An unknown error occurred: ${e.message}";
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
