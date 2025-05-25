import 'package:designhub/features/socials/chat/provider/chat_notifier.dart';
import 'package:designhub/features/content/comment/provider/comment_notifier.dart';
import 'package:designhub/features/content/comment/view/comment_page.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/content/posts/widgets/btn_save.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionIcon extends StatelessWidget {
  final Post post;
  final Profile profile;

  const SectionIcon({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final chatNotifier = context.read<ChatNotifier>();
    final loginNotifier = context.read<CurrentProfileNotifier>();

    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BtnSave(postId: post.postId),
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) =>
                          CommentNotifier(post.postId, post.userId, context),
                      child: CommentPage(),
                    ),
                  )),
              icon: Assets.icons.open.image(height: 30, width: 30)),
          if (loginNotifier.getProfileId() != profile.userId)
            IconButton(
                onPressed: () => chatNotifier.openChat(context, profile),
                icon: Assets.icons.chat.svg(height: 30, width: 30)),
        ],
      ),
    );
  }
}
