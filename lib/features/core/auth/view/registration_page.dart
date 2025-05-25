import 'package:designhub/features/core/auth/view/login_page.dart';
import 'package:designhub/features/core/auth/widgets/registration.dart';
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
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildBackground(context),
              _buildContent(),
              _buildCloseButton(context),
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

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 60),
          Hero(
            tag: "app_icon",
            child: Assets.images.logoText.image(width: 200, height: 200),
          ),
          const SizedBox(height: 60),
          const Registration(),
          const SocialLogin(label: "Or register with"),
          const SizedBox(
            height: 73,
          )
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: 60,
      right: 16,
      child: IconButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ),
        icon: const Icon(Icons.close),
      ),
    );
  }
}
