import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final Profile profile;

  const ProfileInfo({
    super.key,
    required this.profile,
  });

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
            style: CustomTextStyles.bodyMedium(context),
          ),
          SizedBox(height: 16),
          Text("Interests & inpirations",
              style: CustomTextStyles.titleLargeBold(context, FontWeight.bold)),
          SizedBox(height: 6),
          Text(
            profile.interests,
            style: CustomTextStyles.bodyMedium(context),
          ),
          SizedBox(height: 52)
        ],
      ),
    );
  }
}
