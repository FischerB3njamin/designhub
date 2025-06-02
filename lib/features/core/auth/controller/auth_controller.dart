import 'package:designhub/features/core/auth/data/auth_repo.dart';

class AuthController {
  AuthRepo repo;
  AuthController(this.repo);

  Stream<dynamic> get onAuthChanged => repo.onAuthChanged;

  Future<String?> signInWithGoogle() async => repo.signInWithGoogle();
  Future<String?> login(String mail, String pwd) async => repo.login(mail, pwd);
  Future<String?> register(String email, String pwd) async =>
      repo.register(email, pwd);

  Future<void> logout() => repo.signOut();
  Future<String?> resetPassword(String email) async =>
      repo.resetPassword(email);
}
