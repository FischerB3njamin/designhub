import 'package:designhub/features/home/widgets/animated_card_switcher.dart';
import 'package:designhub/features/home/widgets/header_section.dart';
import 'package:designhub/features/posts/data/post_mock_database.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PostMockDatabase db = PostMockDatabase();
    List<Post> posts = db.getPosts(ProfileSingleton().profile!.userId);

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          HeaderSection(),
          ...posts.map((e) => AnimatedCardSwitcher(post: e))
        ],
      ),
    );
  }
}
