import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class CardWithTitle extends StatelessWidget {
  final String postId;
  final controller = PostController();
  late final post = controller.getPostById(postId);

  CardWithTitle({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomBottomSheet.show(
        context,
        PostDetailView(post: post),
        0.9,
      ),
      child: Card(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                ),
                child: Image.network(
                  post.images.first,
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
                      bottomRight: Radius.circular(12)),
                  color: DesignhubColors.white,
                ),
                child: Text(
                  overflow: TextOverflow.clip,
                  post.title,
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
