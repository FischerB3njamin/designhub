import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/view/chat_detail_screen.dart';
import 'package:designhub/features/comment/view/comment_page.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/btn_save.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/rating/view/rating_overview_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SectionIcon extends StatefulWidget {
  final Post post;
  final Profile profile;

  const SectionIcon({
    super.key,
    required this.post,
    required this.profile,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () => CustomBottomSheet.show(
                    context,
                    RatingOverviewPage(posts: [widget.post]),
                    1,
                  ),
              icon: Assets.icons.rating.svg(height: 30, width: 30)),
          BtnSave(postId: widget.post.postId),
          // BtnLike(postId: widget.post.postId),
          IconButton(
              onPressed: () => CustomBottomSheet.show(
                  context,
                  CommentPage(
                    postId: widget.post.postId,
                    creatorId: widget.post.userId,
                  ),
                  0.5),
              icon: Assets.icons.open.image(height: 30, width: 30)),
          IconButton(
              onPressed: () {
                CustomBottomSheet.show(
                    context,
                    ChatDetailScreen(
                        chat: Chat(chatItems: [], participants: [
                          ProfileController().getCurrentProfile().userId,
                          widget.profile.userId,
                        ]),
                        senderProfile: widget.profile),
                    1);
              },
              icon: Assets.icons.chat.svg(height: 30, width: 30)),
        ],
      ),
    );
  }
}
