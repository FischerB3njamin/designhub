import 'package:designhub/features/auth/data/auth_repo.dart';

class AuthController {
  AuthRepo repo;
  AuthController(this.repo);

  get onAuthChanged => repo.onAuthChanged;

  Future<String?> signInWithGoogle() async => repo.signInWithGoogle();
  Future<String?> login(String mail, String pwd) async => repo.login(mail, pwd);
  Future<String?> register(String email, String pwd) async =>
      repo.register(email, pwd);

  Future<void> logout() => repo.logout();
  Future<String?> resetPassword(String email) async =>
      repo.resetPassword(email);
}
