import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/view/profile_page.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class SectionAvatar extends StatelessWidget {
  final Post post;
  final controller = ProfileController();

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
          GestureDetector(
            onTap: () => CustomBottomSheet.show(
              context,
              ProfilePage(
                profile: controller.getProfile(post.userId),
              ),
              0.9,
            ),
            child: AvatarCircle(
              height: 60,
              width: 60,
              profilId: post.userId,
            ),
          ),
          SizedBox(width: 6),
          Text(
            post.creatorName,
            style: TextTheme.of(context)
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
