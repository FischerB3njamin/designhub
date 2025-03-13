import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class CardWithTitle extends StatefulWidget {
  final Post post;
  final Profile profile;
  final bool newRating;

  const CardWithTitle({
    super.key,
    required this.post,
    required this.profile,
    required this.newRating,
  });

  @override
  State<CardWithTitle> createState() => _CardWithTitleState();
}

class _CardWithTitleState extends State<CardWithTitle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomBottomSheet.show(
        context,
        PostDetailView(
          post: widget.post,
          profile: widget.profile,
        ),
        0.9,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
                color: widget.newRating
                    ? DesignhubColors.primary
                    : DesignhubColors.transparent,
                width: 3)),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Image.network(
                  widget.post.images.first,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: DesignhubColors.white,
                ),
                child: Text(
                  overflow: TextOverflow.clip,
                  widget.post.title,
                  style: TextTheme.of(context).bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
