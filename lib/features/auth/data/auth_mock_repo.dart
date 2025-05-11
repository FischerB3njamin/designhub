import 'dart:async';

import 'package:designhub/features/auth/data/auth.mock.dart';
import 'package:designhub/features/auth/data/auth_repo.dart';
import 'package:designhub/features/auth/models/login_data.dart';

class AuthMockRepo extends AuthRepo {
  static final AuthMockRepo _ = AuthMockRepo._internal();
  AuthMockRepo._internal();

  factory AuthMockRepo() => _;
  List<LoginData> data = loginData;

  StreamController<LoginData?> streamController =
      StreamController<LoginData?>();

  @override
  Stream<LoginData?> onAuthChanged() {
    return streamController.stream;
  }

  @override
  Future<void> logout() async {
    streamController.add(null);
  }

  @override
  Future<String?> login(String email, String password) async {
    for (final user in data) {
      if (user.mail == email) {
        if (user.password == password) {
          streamController.add(user);
          return null;
        } else {
          return "Passwort stimmt nicht überein";
        }
      }
    }
    return "falsche login daten";
  }

  @override
  Future<String?> register(String email, String password) async {
    for (final user in data) {
      if (user.mail == email) {
        return "Benutzer existiert bereits";
      }
    }
    final newUser = LoginData(email, password, "UID-${data.length}");
    data.add(newUser);
    streamController.add(newUser);

    return null;
  }

  @override
  Future<String?> signInWithGoogle() async {
    // Hardcoded Google-Account
    String googleTestEmail = "test@google.com";
    LoginData? foundUser;
    for (final user in data) {
      if (user.mail == googleTestEmail) {
        foundUser = user;
      }
    }

    if (foundUser == null) {
      foundUser =
          LoginData(googleTestEmail, googleTestEmail, "UID-${data.length + 1}");
      data.add(foundUser);
    }
    streamController.add(foundUser);
    return null;
  }

  @override
  Future<String?> resetPassword(String email) async {
    return "";
  }
}
