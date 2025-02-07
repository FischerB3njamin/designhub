import 'package:designhub/features/home/widgets/medium_post_card.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/post_detail_view.dart';
import 'package:flutter/material.dart';

class AnimatedCardSwitcher extends StatefulWidget {
  final Post post;
  const AnimatedCardSwitcher({super.key, required this.post});

  @override
  State<AnimatedCardSwitcher> createState() => _AnimatedCardSwitcherState();
}

class _AnimatedCardSwitcherState extends State<AnimatedCardSwitcher> {
  bool isMedium = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.linear,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMedium = !isMedium;
          });
        },
        child: isMedium
            ? MediumPostCard(
                key: ValueKey<bool>(isMedium),
                post: widget.post,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: PostDetailView(
                    key: ValueKey<bool>(isMedium),
                    post: widget.post,
                  ),
                ),
              ),
      ),
    );
  }
}
