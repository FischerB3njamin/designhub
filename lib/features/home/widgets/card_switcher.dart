import 'package:designhub/features/home/widgets/card_post.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:flutter/material.dart';

class CardSwitcher extends StatefulWidget {
  final Post post;
  const CardSwitcher({super.key, required this.post});

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
