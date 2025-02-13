import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/btn_like.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class CardPost extends StatelessWidget {
  final Post post;

  const CardPost({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 500,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(030),
        )
            // borderRadius: BorderRadius.circular(30.0),
            ),
        elevation: 10,
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Image.network(
                post.images.first,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: DesignhubColors.white,
                    borderRadius: BorderRadius.circular(36)),
                child: Row(
                  children: [
                    AvatarCircle(profilId: post.userId, height: 60, width: 60),
                    SizedBox(width: 8),
                    Text(
                      post.creatorName,
                      style: TextTheme.of(context).headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: BtnLike(
                        postId: post.postId,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
