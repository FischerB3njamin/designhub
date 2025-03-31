import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/auth/data/auth_firebase_repo.dart';
import 'package:designhub/features/auth/data/auth_mock_db.dart';
import 'package:designhub/features/auth/data/auth_repo.dart';
import 'package:designhub/firebase_options.dart';
import 'package:designhub/main_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  // Repos
  AuthMockDB authMockDb = AuthMockDB();
  AuthRepo authFirebase = AuthFirebase(auth);

  final AuthController authController = AuthController();

  // replace it with the mock(authMockDb) or Firebase.auth(authFirebase)
  // if set so AUthMockDB toggle the
  authController.initRepo(authFirebase);
  runApp(MainApp(authController: authController));
}
