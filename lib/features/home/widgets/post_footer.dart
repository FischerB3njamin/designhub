import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class PostFooter extends StatelessWidget {
  final Profile profile;
  final Post post;

  const PostFooter({
    super.key,
    required this.profile,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    var theme = TextTheme.of(context);
    return Container(
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: DesignhubColors.white.withAlpha(230),
        borderRadius: BorderRadius.all(Radius.circular(34)),
      ),
      child: Row(
        children: [
          AvatarCircle(
            profile: profile,
            height: 70,
            width: 70,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextLine(context, post.title,
                    theme.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
                _buildTextLine(context, post.description,
                    theme.bodyLarge!.copyWith(color: DesignhubColors.black54)),
                _buildTextLine(context, post.hashtags,
                    theme.bodyMedium!.copyWith(color: DesignhubColors.black26)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextLine(BuildContext context, String text, TextStyle style) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
