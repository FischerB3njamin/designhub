import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/widgets/small_image_card_overview.dart';
import 'package:flutter/material.dart';

class ProfileWorkView extends StatelessWidget {
  final Profile profile;

  const ProfileWorkView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SmallImageCardOverview(postIds: profile.posts, type: "title");
  }
}
