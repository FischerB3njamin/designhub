import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/section_avatar.dart';
import 'package:designhub/features/posts/widgets/section_question_detailview.dart';
import 'package:designhub/features/posts/widgets/section_icon.dart';
import 'package:designhub/features/posts/widgets/section_post_detail.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class PostDetailView extends StatelessWidget {
  final Post post;
  final ProfileController profileController = ProfileController();
  final Profile profile;

  PostDetailView({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    String userId = profileController.getCurrentProfile().userId;
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
              SectionIcon(post: post, profile: profile),
              SectionAvatar(post: post, profile: profile),
              SectionPostDetail(post: post),
              if (post.userId != userId) SizedBox(height: 50),
              if (post.userId == userId)
                SectionQuestionDetailview(post: post, profile: profile),
            ],
          ),
        ),
      ),
    );
  }
}
