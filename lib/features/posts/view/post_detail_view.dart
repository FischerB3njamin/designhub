import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/section_avatar.dart';
import 'package:designhub/features/posts/widgets/section_question_detailview.dart';
import 'package:designhub/features/posts/widgets/section_icon.dart';
import 'package:designhub/features/posts/widgets/section_post_detail.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:flutter/material.dart';

class PostDetailView extends StatelessWidget {
  final Post post;

  const PostDetailView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Padding(
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
              SectionIcon(post: post),
              SectionAvatar(post: post),
              SectionPostDetail(post: post),
              if (post.userId != ProfileSingleton().profile?.userId)
                SizedBox(height: 50),
              if (post.userId == ProfileSingleton().profile?.userId)
                SectionQuestionDetailview(post: post),
            ],
          ),
        ),
      ),
    );
  }
}
