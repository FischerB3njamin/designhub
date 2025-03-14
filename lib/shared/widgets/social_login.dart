import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/shared/widgets/social_button.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  final String label;

  const SocialLogin({super.key, required this.label});

  Future<void> navigateToHome(String userId, BuildContext context) async {
    final profileController = ProfileController();
    final profile = await profileController.getProfile(userId);
    profileController.setCurrentProfile(profile);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavigationPage()),
    );
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
              Text(label),
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
            SocialButton(
              icon: Assets.icons.googleLogo,
              label: "Google",
              //direct login as Dante Moor only for testing
              onPressed: () => navigateToHome("uid-0001", context),
            ),
            SizedBox(
              width: 16,
            ),
            SocialButton(
              icon: Assets.icons.appleLogo,
              label: "Apple",
              // direct login as Paul only for testing
              onPressed: () => navigateToHome("uid-0002", context),
            ),
          ],
        )
      ],
    );
  }
}
