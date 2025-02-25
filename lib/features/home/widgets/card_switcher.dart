import 'package:designhub/features/home/widgets/card_post.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class CardSwitcher extends StatefulWidget {
  final Post post;
  final Profile profile;
  const CardSwitcher({super.key, required this.post, required this.profile});

  @override
  State<CardSwitcher> createState() => _CardSwitcherState();
}

class _CardSwitcherState extends State<CardSwitcher> {
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
            ? CardPost(
                key: ValueKey<bool>(isMedium),
                post: widget.post,
                profile: widget.profile,
              )
            : Card(
                child: PostDetailView(
                  key: ValueKey<bool>(isMedium),
                  post: widget.post,
                  profile: widget.profile,
                ),
              ),
      ),
    );
  }
}
