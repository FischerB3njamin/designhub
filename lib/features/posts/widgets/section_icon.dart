import 'package:designhub/features/comment/view/comment_page.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/btn_like.dart';
import 'package:designhub/features/posts/widgets/btn_save.dart';
import 'package:designhub/features/rating/view/rating_overview_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SectionIcon extends StatefulWidget {
  final Post post;

  const SectionIcon({
    super.key,
    required this.post,
  });

  @override
  State<SectionIcon> createState() => _SectionIconState();
}

class _SectionIconState extends State<SectionIcon> {
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
                    RatingOverviewPage(posts: [widget.post]),
                    1,
                  ),
              icon: Assets.icons.rating.svg()),
          BtnSave(postId: widget.post.postId),
          BtnLike(postId: widget.post.postId),
          IconButton(
              onPressed: () => CustomBottomSheet.show(
                  context, CommentPage(postId: widget.post.postId), 0.5),
              icon: Assets.icons.open.image(height: 30, width: 30)),
          IconButton(
              onPressed: () {},
              icon: Assets.icons.share.svg(height: 30, width: 30)),
        ],
      ),
    );
  }
}
