import 'package:designhub/features/auth/view/login_page.dart';
import 'package:designhub/theme/custom_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getCustomTheme(),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
