import 'package:designhub/features/follow/widgets/btn_follow.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/btn_like.dart';
import 'package:designhub/features/profile/models/profile.dart';

import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class SectionAvatar extends StatefulWidget {
  final Post post;
  final Profile profile;
  const SectionAvatar({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  State<SectionAvatar> createState() => _SectionAvatarState();
}

class _SectionAvatarState extends State<SectionAvatar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          AvatarCircle(
            height: 60,
            width: 60,
            profile: widget.profile,
          ),
          SizedBox(width: 6),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 0,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  widget.profile.name,
                  style: TextTheme.of(context)
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              BtnFollow(profilId: widget.post.userId)
            ],
          ),
          Spacer(),
          BtnLike(postId: widget.post.postId)
        ],
      ),
    );
  }
}
