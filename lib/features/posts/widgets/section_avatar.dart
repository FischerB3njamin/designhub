import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';

import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class SectionAvatar extends StatelessWidget {
  final Post post;
  final controller = ProfileController();
  late final profile = controller.getProfile(post.userId);
  SectionAvatar({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          AvatarCircle(
            height: 60,
            width: 60,
            profilId: post.userId,
          ),
          SizedBox(width: 6),
          Text(
            profile.name,
            style: TextTheme.of(context)
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
