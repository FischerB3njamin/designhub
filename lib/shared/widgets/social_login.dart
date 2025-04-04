import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatefulWidget {
  final AuthController authController;
  final String label;

  const SocialLogin({
    super.key,
    required this.label,
    required this.authController,
  });

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  Future<void> navigateToHome(String userId, BuildContext context) async {
    final profileController = ProfileController();
    final profile = await profileController.getProfile(userId);
    profileController.setCurrentProfile(profile.userId);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Divider(),
              ),
              SizedBox(width: 16),
              Text(widget.label),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Divider(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Assets.icons.googleLogo.image(height: 30, width: 30),
              onPressed: () => widget.authController.signInWithGoogle(),
            ),
          ],
        )
      ],
    );
  }
}
