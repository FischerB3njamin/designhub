import 'package:designhub/features/core/auth/provider/auth_notifier.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialLogin extends StatelessWidget {
  final String label;

  const SocialLogin({
    super.key,
    required this.label,
  });

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
            IconButton(
              icon: Assets.icons.googleLogo.image(height: 30, width: 30),
              onPressed: () => context.read<AuthNotifier>().signInWithGoogle(),
            ),
          ],
        )
      ],
    );
  }
}
