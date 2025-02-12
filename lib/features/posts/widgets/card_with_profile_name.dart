import 'package:designhub/features/posts/data/post_mock_db.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class CardWithProfileName extends StatelessWidget {
  final String postId;
  final Function callback;

  const CardWithProfileName({
    super.key,
    required this.postId,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    PostMockDB db = PostMockDB();
    Post post = db.getPostById(postId);

    return GestureDetector(
      onTap: () async {
        await CustomBottomSheet.showAsync(
            context, PostDetailView(post: post), 0.9);
        callback();
      },
      child: SizedBox.expand(
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: DesignhubColors.black12),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(16)),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
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
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(16)),
                    color: DesignhubColors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          post.creatorImage,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        post.creatorName,
                        style: TextTheme.of(context).bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
