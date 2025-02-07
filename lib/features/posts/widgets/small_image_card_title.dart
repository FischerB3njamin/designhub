import 'package:designhub/features/posts/data/post_mock_database.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/bs_detail_view.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SmallImageCardTitle extends StatelessWidget {
  final String postId;

  const SmallImageCardTitle({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    PostMockDatabase db = PostMockDatabase();
    Post post = db.getPostById(postId);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => BsDetailView(
            post: post,
          ),
        );
      },
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
