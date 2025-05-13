import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/shared/provider/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthNotifier extends BaseUiProvider {
  bool _hidePasswort = true;
  bool _hideRepeatPasswort = true;
  bool _termsAndConditions = false;
  late AuthController authController;
  AuthNotifier(BuildContext context) {
    authController = context.read<AuthController>();
  }

  bool get hidePasswort => _hidePasswort;
  bool get hideRepeatPasswort => _hideRepeatPasswort;
  bool get termsAndConditions => _termsAndConditions;

  void togglePasswort() {
    _hidePasswort = !hidePasswort;
    notifyListeners();
  }

  void toggleRepeatedPasswort() {
    _hideRepeatPasswort = !_hideRepeatPasswort;
    notifyListeners();
  }

  void toggleTermsAndConditions(bool value) {
    _termsAndConditions = value;
    notifyListeners();
  }

  void handleLogin(
      GlobalKey<FormState> formKey, String email, String password) async {
    if (!formKey.currentState!.validate()) return;

    final error = await authController.login(email, password);

    if (error != null) {
      setError(error);
    }
    notifyListeners();
  }

  Future<void> handleSignup(
    GlobalKey<FormState> formKey,
    String email,
    String pwd,
    bool pwdIsEqual,
  ) async {
    if (!formKey.currentState!.validate()) return;

    if (!pwdIsEqual) {
      setError("Password not identical");
      return;
    }
    setLoading(true);

    String? result = await authController.register(email, pwd);
    setLoading(false);

    if (result != null) {
      setError(result);
    }
  }

// Repo functions
  Future<void> logout() => authController.logout();

  Stream<dynamic> get onAuthChanged => authController.onAuthChanged;

  Future<String?> signInWithGoogle() => authController.signInWithGoogle();

  Future<String?> resetPassword(String email) =>
      authController.resetPassword(email);

  Future<String?> login(String email, String password) =>
      authController.login(email, password);

  Future<String?> register(String email, String password) =>
      authController.register(email, password);
}
