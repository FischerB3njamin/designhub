import 'package:designhub/features/posts/models/post.dart';
import 'package:flutter/material.dart';

class SectionPostDetail extends StatelessWidget {
  final Post post;

  const SectionPostDetail({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
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
      ),
    );
  }
}
