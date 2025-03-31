import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/auth/widgets/login.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/widgets/social_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController;

  const LoginPage({
    super.key,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Hero(
                    tag: "bg_image",
                    child: Assets.images.bg.image(),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 65),
                    Hero(
                      tag: "app_icon",
                      child:
                          Assets.images.logoText.image(width: 200, height: 200),
                    ),
                    SizedBox(height: 40),
                    Login(
                      authController: authController,
                    ),
                    SocialLogin(
                      label: "Or login with",
                      authController: authController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
