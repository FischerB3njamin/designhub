import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SectionPostDetail extends StatelessWidget {
  final Post post;

  const SectionPostDetail({
    super.key,
    required this.post,
  });

  List<String> splitHashtags(String hashtags) {
    List<String> hashtag = [];
    for (final item in hashtags.split('#')) {
      if (item.trim().isNotEmpty) hashtag.add(item.trim());
    }

    return hashtag;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: TextTheme.of(context).headlineMedium,
          ),
          Wrap(
            children: [
              for (final item in splitHashtags(post.hashtags))
                Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: DesignhubColors.black26),
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    item,
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ),
            ],
          ),
          Text(
            post.description,
            style: TextTheme.of(context).bodyMedium,
          ),
        ],
      ),
    );
  }
}
