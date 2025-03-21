import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/card_with_profile_name.dart';
import 'package:designhub/features/posts/widgets/card_with_title.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class SectionProfilCard extends StatefulWidget {
  final Profile profile;
  final String type;
  final List<Post> posts;
  final List<Profile> profiles;
  final List<News> news;
  final Function callback;

  const SectionProfilCard({
    super.key,
    required this.profile,
    required this.type,
    required this.posts,
    required this.profiles,
    required this.news,
    required this.callback,
  });

  @override
  State<SectionProfilCard> createState() => _SectionProfilCardState();
}

class _SectionProfilCardState extends State<SectionProfilCard> {
  Profile? getProfile(String postId) {
    final post =
        widget.posts.where((post) => post.postId == postId).firstOrNull;

    if (post == null) {
      return null;
    }

    return widget.profiles
        .where((profile) => profile.userId == post.userId)
        .firstOrNull;
  }

  Post getPost(String postId) =>
      widget.posts.firstWhere((post) => post.postId == postId);
  @override
  Widget build(BuildContext context) {
    List<String> postIds = widget.type == 'title'
        ? widget.profile.posts
        : widget.profile.savedPosts;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 400,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            ...postIds.map(
              (postId) {
                final post = getPost(postId);
                final profile = getProfile(postId);
                return widget.type == 'title'
                    ? CardWithTitle(
                        post: post,
                        profile: profile!,
                        callback: widget.callback,
                        newRating: widget.news
                            .where(((e) => postId == e.postId))
                            .firstOrNull)
                    : CardWithProfileName(
                        post: post,
                        callback: () => setState(() {}),
                        profile: profile!,
                      );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
