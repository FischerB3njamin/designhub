abstract class AuthRepo {
  Future<String> addUser(String name, String email, String pwd);
  Future<String> checkLogin(String mail, String pwd);
  Future<bool> mailNotInDb(String mail);
}
