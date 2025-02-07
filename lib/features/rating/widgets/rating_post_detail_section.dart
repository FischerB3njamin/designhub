import 'package:designhub/features/posts/models/post.dart';
import 'package:flutter/material.dart';

class RatingPostDetailSection extends StatelessWidget {
  final Post post;

  const RatingPostDetailSection({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: post.images
                .map((e) => Card(
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        e,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width - 32,
                      ),
                    ))
                .toList(),
          ),
        ),
        Text(
          post.title,
          style: TextTheme.of(context).headlineLarge,
        ),
        Text(
          post.description,
          style: TextTheme.of(context).bodyMedium,
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
