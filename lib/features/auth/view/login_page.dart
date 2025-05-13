import 'package:designhub/features/auth/widgets/login.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/widgets/social_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildBackground(context),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Positioned(
      child: SizedBox(
        width: double.infinity,
        child: Hero(
          tag: "bg_image",
          child: Assets.images.bg.image(fit: BoxFit.fitWidth),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 65),
          Hero(
            tag: "app_icon",
            child: Assets.images.logoText.image(width: 200, height: 200),
          ),
          const SizedBox(height: 40),
          const Login(),
          const SocialLogin(label: "Or login with"),
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}
