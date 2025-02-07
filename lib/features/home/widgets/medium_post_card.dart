import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/animated_like_button.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class MediumPostCard extends StatelessWidget {
  const MediumPostCard({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
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
                      Container(
                        height: 60,
                        width: 60,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          post.creatorImage,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                        child: AnimatedLikeButton(
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
      ),
    );
  }
}
