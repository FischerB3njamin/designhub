import 'package:designhub/features/auth/provider/auth_notifier.dart';
import 'package:designhub/features/auth/view/login_page.dart';
import 'package:designhub/features/navigation/provider/navigation_notifier.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/controller/push_notification_controller.dart';
import 'package:designhub/theme/custom_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget initNaviagtation(BuildContext context, String uid) {
    context.read<CurrentProfileNotifier>().setUid(uid);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<NavigationNotifier>().reinit(context);
      await PushNotificationService().init(uid);
    });

    return NavigationPage();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<AuthNotifier>();
    return StreamBuilder<User?>(
        stream: notifier.onAuthChanged as Stream<User?>,
        builder: (context, snapshot) {
          final isLoggedIn = snapshot.data != null;
          final user = snapshot.data;

          return MaterialApp(
            key: isLoggedIn ? Key("logged_in") : Key("not_logged_in"),
            theme: getCustomTheme(context),
            debugShowCheckedModeBanner: false,
            title: 'designHub',
            home:
                isLoggedIn ? initNaviagtation(context, user!.uid) : LoginPage(),
          );
        });
  }
}
