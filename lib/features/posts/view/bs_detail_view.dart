import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/post_detail_view.dart';
import 'package:flutter/material.dart';

class BsDetailView extends StatelessWidget {
  const BsDetailView({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: SingleChildScrollView(
          child: SizedBox(
            child: PostDetailView(post: post),
          ),
        ),
      ),
    );
  }
}
