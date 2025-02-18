import 'package:designhub/features/auth/data/auth.mock.dart';
import 'package:designhub/features/auth/data/auth_repo.dart';
import 'package:designhub/features/auth/models/login_data.dart';

class AuthMockDB extends AuthRepo {
  static final AuthMockDB _ = AuthMockDB._internal();
  AuthMockDB._internal();

  factory AuthMockDB() => _;
  List<LoginData> data = loginData;

  @override
  bool mailNotInDb(String mail) {
    return data.where((e) => e.mail == mail).isEmpty;
  }

  @override
  String addUser(String name, String email, String pwd) {
    String userId = "uid-00${data.length + 1}";
    data.add(LoginData(email, pwd, userId));
    return userId;
  }

  @override
  String checkLogin(String mail, String pwd) {
    for (var item in data) {
      if (item.mail == mail && item.password == pwd) return item.id;
    }
    return "";
  }
}
