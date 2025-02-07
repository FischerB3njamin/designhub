import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/avatar_section.dart';
import 'package:designhub/features/posts/widgets/detail_view_question_section.dart';
import 'package:designhub/features/posts/widgets/icon_section.dart';
import 'package:designhub/features/posts/widgets/post_detail_section.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:flutter/material.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        children: [
          ...post.images.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.network(e,
                  width: double.infinity, fit: BoxFit.fitWidth),
            ),
          ),
          IconSection(post: post),
          AvatarSection(post: post),
          PostDetailSection(post: post),
          if (post.userId != ProfileSingleton().profile?.userId)
            SizedBox(height: 50),
          if (post.userId == ProfileSingleton().profile?.userId)
            DetailViewQuestionSection(post: post),
        ],
      ),
    );
  }
}
