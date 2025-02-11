import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/widgets/section_profile_card.dart';
import 'package:flutter/material.dart';

class ProfileWork extends StatelessWidget {
  final Profile profile;

  const ProfileWork({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SectionProfileCard(postIds: profile.posts, type: "title");
  }
}
