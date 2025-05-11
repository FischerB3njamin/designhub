import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';

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
            style: CustomTextStyles.headlineMedium(context),
          ),
          LinkText(
            post.description,
            textStyle: CustomTextStyles.bodyMedium(context),
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
                    style: CustomTextStyles.bodyMedium(context),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
