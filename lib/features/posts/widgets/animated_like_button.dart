import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class AnimatedLikeButton extends StatefulWidget {
  final String postId;

  const AnimatedLikeButton({
    super.key,
    required this.postId,
  });

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton> {
  late bool liked = ProfileSingleton().profile!.liked!.contains(widget.postId);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: IconButton(
          key: ValueKey<bool>(liked),
          onPressed: () {
            setState(() {
              liked = !liked;
            });
          },
          icon: liked
              ? Assets.icons.like
                  .image(height: 30, width: 30, color: DesignhubColors.primary)
              : Assets.icons.like.image(height: 30, width: 30)),
    );
  }
}
