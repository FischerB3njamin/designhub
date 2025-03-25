import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/features/posts/widgets/btn_like.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class CardPost extends StatelessWidget {
  final Post post;
  final Profile profile;

  const CardPost({
    super.key,
    required this.post,
    required this.profile,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomBottomSheet.show(
          context, PostDetailView(post: post, profile: profile), 0.9),
      child: Container(
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
            ),
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
                  // height: 50,
                  decoration: BoxDecoration(
                      color: DesignhubColors.white,
                      borderRadius: BorderRadius.circular(36)),
                  child: Row(
                    children: [
                      AvatarCircle(profile: profile, height: 50, width: 50),
                      SizedBox(width: 8),
                      Column(
                        spacing: 0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name,
                            style:
                                TextTheme.of(context).headlineSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
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
      ),
    );
  }
}
