import 'package:designhub/features/auth/data/login.mock.dart';
import 'package:designhub/features/auth/data/login_database_repo.dart';
import 'package:designhub/features/auth/models/login_data.dart';

class LoginMockDatabase extends LoginDatabaseRepo {
  List<LoginData> data = loginData;

  @override
  void addUser(String name, String email, String pwd) {
    data.add(LoginData(email, pwd, "uid-00${data.length + 1}"));
  }

  @override
  String checkLogin(String mail, String pwd) {
    for (var item in data) {
      if (item.mail == mail && item.password == pwd) return item.id;
    }
    return "";
  }
}
