abstract class LoginRepo {
  String addUser(String name, String email, String pwd);
  String checkLogin(String mail, String pwd);
  bool mailNotInDb(String mail);
}
