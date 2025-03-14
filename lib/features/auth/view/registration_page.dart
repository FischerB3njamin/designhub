import 'package:designhub/features/auth/view/login_page.dart';
import 'package:designhub/features/auth/widgets/registration.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/widgets/social_login.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

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
                      Registration(),
                      SocialLogin(label: "Or register with")
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
                      builder: (context) => LoginPage(),
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
