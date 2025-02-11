import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/widgets/section_profile_card.dart';
import 'package:flutter/material.dart';

class ProfileSaved extends StatelessWidget {
  final Profile profile;

  const ProfileSaved({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SectionProfileCard(
      postIds: profile.savedPosts,
      type: 'name',
    );
  }
}
