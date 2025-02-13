import 'package:designhub/features/home/widgets/card_switcher.dart';
import 'package:designhub/features/home/widgets/section_header.dart';
import 'package:designhub/features/posts/data/post_mock_db.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PostMockDB db = PostMockDB();
    List<Post> posts = db.getPosts(ProfileSingleton().profile!.userId);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SectionHeader(),
          Container(
            height: 580,
            child: ListWheelScrollView(
              itemExtent: 550,
              diameterRatio: 10,
              physics: FixedExtentScrollPhysics(),
              controller: FixedExtentScrollController(),
              children: [...posts.map((e) => CardSwitcher(post: e))],
            ),
          ),
        ],
      ),
    );
  }
}
