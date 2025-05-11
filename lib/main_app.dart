import 'package:designhub/features/auth/provider/auth_notifier.dart';
import 'package:designhub/features/auth/view/login_page.dart';
import 'package:designhub/features/navigation/provider/navigation_notifier.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/theme/custom_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getCustomTheme(context),
      debugShowCheckedModeBanner: false,
      title: 'designHub',
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    return StreamBuilder<dynamic>(
      stream: authNotifier.onAuthChanged(),
      builder: (context, authSnapshot) {
        final user = authSnapshot.data;

        if (user == null) {
          return const LoginPage();
        }

        return FutureBuilder<bool>(
          future:
              context.read<CurrentProfileNotifier>().init((user as User).uid),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (profileSnapshot.hasData && profileSnapshot.data == true) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<NavigationNotifier>().reinit(context);
              });
            }

            return const NavigationPage();
          },
        );
      },
    );
  }
}
