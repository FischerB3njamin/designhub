import 'package:designhub/features/content/news/models/news.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/content/posts/widgets/card_with_title.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/shared/widgets/empty_posts.dart';
import 'package:flutter/material.dart';

class SectionProfilCard extends StatelessWidget {
  final Profile profile;
  final List<Post> posts;
  final List<Profile> profiles;
  final List<News> news;

  const SectionProfilCard({
    super.key,
    required this.profile,
    required this.posts,
    required this.profiles,
    required this.news,
  });

  Profile? getProfile(String postId) {
    final post = posts.where((post) => post.postId == postId).firstOrNull;
    if (post != null && profiles.any((e) => e.userId == post.userId)) {
      return profiles.firstWhere(
        (p) => p.userId == post.userId,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: posts.isEmpty
          ? EmptyPosts()
          : GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                ...posts.map((post) {
                  final profile = getProfile(post.postId);
                  if (profile == null) return SizedBox.shrink();
                  return CardWithTitle(
                    post: post,
                    profile: profile,
                  );
                }),
              ],
            ),
    );
  }
}
