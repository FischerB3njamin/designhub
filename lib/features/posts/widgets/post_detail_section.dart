import 'package:designhub/features/posts/models/post.dart';
import 'package:flutter/material.dart';

class PostDetailSection extends StatelessWidget {
  const PostDetailSection({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title,
          style: TextTheme.of(context).headlineMedium,
        ),
        SizedBox(height: 12),
        Text(
          post.description,
          style: TextTheme.of(context).bodyMedium,
        ),
        SizedBox(height: 12),
        Text(
          post.hashtags,
          style: TextTheme.of(context).bodyMedium,
        )
      ],
    );
  }
}
