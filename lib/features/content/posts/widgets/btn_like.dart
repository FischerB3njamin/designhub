import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BtnLike extends StatelessWidget {
  final String postId;

  const BtnLike({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    final currentProfileNotifier = context.watch<CurrentProfileNotifier>();
    bool liked = currentProfileNotifier.getLike(postId);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: IconButton(
          key: ValueKey<bool>(liked),
          onPressed: () => currentProfileNotifier.toggleLike(postId),
          icon: liked
              ? Assets.icons.like
                  .image(height: 30, width: 30, color: DesignhubColors.primary)
              : Assets.icons.like.image(height: 30, width: 30)),
    );
  }
}
