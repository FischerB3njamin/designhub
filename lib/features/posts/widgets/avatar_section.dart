import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/view/bs_profile_view.dart';
import 'package:flutter/material.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => BsProfileView(profileId: post.userId),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.network(post.creatorImage, fit: BoxFit.cover),
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
