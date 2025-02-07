import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/rating/view/rating_page.dart';
import 'package:flutter/material.dart';

class BsRatingScreen extends StatelessWidget {
  const BsRatingScreen({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 1,
        child: SizedBox(
          child: RatingPage(posts: [post]),
        ),
      ),
    );
  }
}
