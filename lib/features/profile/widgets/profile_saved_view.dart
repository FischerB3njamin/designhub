import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/widgets/small_image_card_overview.dart';
import 'package:flutter/material.dart';

class ProfileSavedView extends StatelessWidget {
  final Profile profile;

  const ProfileSavedView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SmallImageCardOverview(
      postIds: profile.savedPosts,
      type: 'name',
    );
  }
}
