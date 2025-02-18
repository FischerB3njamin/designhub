import 'package:designhub/features/home/widgets/card_switcher.dart';
import 'package:designhub/features/home/widgets/section_header.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ProfileController profileController = ProfileController();

  HomePage({super.key});
  final controller = PostController();
  late final posts =
      controller.getPosts(profileController.getCurrentProfile().userId);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SectionHeader(),
          SizedBox(
            height: 580,
            child: ListWheelScrollView(
              itemExtent: 550,
              diameterRatio: 10,
              physics: FixedExtentScrollPhysics(),
              controller: FixedExtentScrollController(),
              children: posts.map((e) => CardSwitcher(post: e)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
