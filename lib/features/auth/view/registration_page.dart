import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/auth/view/login_page.dart';
import 'package:designhub/features/auth/widgets/registration.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/widgets/social_login.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  final AuthController authController;

  const RegistrationPage({super.key, required this.authController});

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
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      Hero(
                          tag: "app_icon",
                          child: Assets.images.logoText
                              .image(width: 200, height: 200)),
                      SizedBox(height: 60),
                      Registration(
                        authController: authController,
                      ),
                      SocialLogin(
                        label: "Or register with",
                        authController: authController,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 16,
                child: IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        authController: authController,
                      ),
                    ),
                  ),
                  icon: Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
