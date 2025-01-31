import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/shared/widgets/social_button.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  final String label;
  const SocialLogin({super.key, required this.label});

  void navigatToHomepage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NavigationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 105,
              child: Divider(),
            ),
            SizedBox(width: 16),
            Text(label),
            SizedBox(width: 16),
            SizedBox(
              width: 105,
              child: Divider(),
            ),
          ],
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
              onPressed: () => navigatToHomepage(context),
            ),
            SizedBox(
              width: 16,
            ),
            SocialButton(
              icon: Assets.icons.appleLogo,
              label: "Apple",
              onPressed: () => navigatToHomepage(context),
            ),
          ],
        )
      ],
    );
  }
}
