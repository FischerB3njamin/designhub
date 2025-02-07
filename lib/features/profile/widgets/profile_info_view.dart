import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class ProfileInfoView extends StatelessWidget {
  final Profile profile;
  const ProfileInfoView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About me",
            style: TextTheme.of(context)
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            profile.aboutMe,
            style: TextTheme.of(context).bodyMedium,
          ),
          SizedBox(height: 16),
          Text(
            "Interests & inpirations",
            style: TextTheme.of(context)
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            profile.interests,
            style: TextTheme.of(context).bodyMedium,
          ),
          SizedBox(height: 52)
        ],
      ),
    );
  }
}
