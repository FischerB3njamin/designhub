abstract class AuthRepo {
  Future<void> logout();
  Stream<dynamic> get onAuthChanged;
  Future<String?> signInWithGoogle();
  Future<String?> login(String email, String password);
  Future<String?> register(String email, String password);
  Future<String?> resetPassword(String email);
}
