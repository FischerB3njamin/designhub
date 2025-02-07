import 'package:designhub/features/posts/data/post_mock_database.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/bs_detail_view.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SmallImageCardName extends StatelessWidget {
  final String postId;
  const SmallImageCardName({super.key, required this.postId});

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
