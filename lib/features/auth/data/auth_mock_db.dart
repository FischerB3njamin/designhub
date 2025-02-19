import 'package:designhub/features/auth/data/auth.mock.dart';
import 'package:designhub/features/auth/data/auth_repo.dart';
import 'package:designhub/features/auth/models/login_data.dart';

class AuthMockDB extends AuthRepo {
  static final AuthMockDB _ = AuthMockDB._internal();
  AuthMockDB._internal();

  factory AuthMockDB() => _;
  List<LoginData> data = loginData;

  @override
  Future<bool> mailNotInDb(String mail) async {
    return Future.delayed(
        Duration(seconds: 1), () => data.where((e) => e.mail == mail).isEmpty);
  }

  @override
  Future<String> addUser(String name, String email, String pwd) async {
    return Future.delayed(Duration(seconds: 1), () {
      String userId = "uid-00${data.length + 1}";
      data.add(LoginData(email, pwd, userId));
      return userId;
    });
  }

  @override
  Future<String> checkLogin(String mail, String pwd) {
    return Future.delayed(Duration(seconds: 1), () {
      for (var item in data) {
        if (item.mail == mail && item.password == pwd) return item.id;
      }
      return "";
    });
  }
}
