import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/animated_like_button.dart';
import 'package:designhub/features/posts/widgets/animated_saved_button.dart';
import 'package:designhub/features/rating/view/rating_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class IconSection extends StatefulWidget {
  final Post post;

  const IconSection({super.key, required this.post});

  @override
  State<IconSection> createState() => _IconSectionState();
}

class _IconSectionState extends State<IconSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => CustomBottomSheet.show(
                    context,
                    RatingPage(posts: [widget.post]),
                    1,
                  ),
              icon: Assets.icons.rating.svg()),
          AnimatedSavedButton(postId: widget.post.postId),
          AnimatedLikeButton(postId: widget.post.postId),
          IconButton(
              onPressed: () {},
              icon: Assets.icons.open.image(height: 30, width: 30)),
          IconButton(
              onPressed: () {},
              icon: Assets.icons.share.svg(height: 30, width: 30)),
        ],
      ),
    );
  }
}
