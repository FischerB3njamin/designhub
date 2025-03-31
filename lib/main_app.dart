import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/auth/models/login_data.dart';
import 'package:designhub/features/auth/view/login_page.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/theme/custom_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  final AuthController authController;
  const MainApp({
    super.key,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    // update the spcific type for the stream Authmockdb -> LoginData), Firestore -> User?
    return StreamBuilder<User?>(
        stream: authController.onAuthChanged(),
        builder: (context, snapshot) {
          final isLoggedIn = snapshot.data != null;
          final user = snapshot.data;
          return MaterialApp(
              theme: getCustomTheme(),
              debugShowCheckedModeBanner: false,
              key: isLoggedIn ? Key("logged_in") : Key("not_logged_in"),
              title: 'Flutter Demo',
              home: isLoggedIn
                  ? FutureBuilder(
                      //for the Firebase auth
                      future: ProfileController()
                          .setCurrentProfile((user as User).uid),
                      // for the authMockDB
                      // future: ProfileController()
                      //     .setCurrentProfile((user as LoginData).uid),
                      builder: (context, profileSnapshot) {
                        if (profileSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (profileSnapshot.hasData &&
                            profileSnapshot.data == true) {
                          return NavigationPage(
                            index: 3,
                          );
                        } else {
                          return NavigationPage(index: 0);
                        }
                      },
                    )
                  : LoginPage(authController: authController));
        });
  }
}
