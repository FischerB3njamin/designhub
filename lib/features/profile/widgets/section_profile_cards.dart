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

  const SectionProfilCard({
    super.key,
    required this.profile,
    required this.type,
    required this.posts,
    required this.profiles,
  });

  @override
  State<SectionProfilCard> createState() => _SectionProfilCardState();
}

class _SectionProfilCardState extends State<SectionProfilCard> {
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
              (postId) => widget.type == 'title'
                  ? CardWithTitle(
                      post: widget.posts
                          .firstWhere((post) => post.postId == postId),
                      profile: widget.profiles.firstWhere((e) =>
                          e.userId ==
                          widget.posts
                              .firstWhere((post) => post.postId == postId)
                              .userId),
                    )
                  : CardWithProfileName(
                      post: widget.posts
                          .firstWhere((post) => post.postId == postId),
                      callback: () => setState(() {}),
                      profile: widget.profiles.firstWhere((e) =>
                          e.userId ==
                          widget.posts
                              .firstWhere((post) => post.postId == postId)
                              .userId),
                    ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
