import 'package:designhub/features/auth/data/auth_mock_db.dart';
import 'package:designhub/features/auth/data/auth_repo.dart';

class AuthController {
  AuthRepo repo = AuthMockDB();

  Future<String> checkLogin(String mail, String pwd) =>
      repo.checkLogin(mail, pwd);
  Future<String> addUser(String name, String email, String pwd) =>
      repo.addUser(name, email, pwd);
  Future<bool> mailNotInDb(String mail) => repo.mailNotInDb(mail);
}
