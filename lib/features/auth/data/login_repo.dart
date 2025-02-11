abstract class LoginRepo {
  void addUser(String name, String email, String pwd);
  String checkLogin(String mail, String pwd);
}
