import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class BtnLike extends StatefulWidget {
  final String postId;

  const BtnLike({
    super.key,
    required this.postId,
  });

  @override
  State<BtnLike> createState() => _BtnLikeState();
}

class _BtnLikeState extends State<BtnLike> {
  ProfileController profileController = ProfileController();
  late Profile profile;
  late bool liked;

  @override
  void initState() {
    super.initState();
    profile = profileController.getCurrentProfile();
    liked = profile.liked!.contains(widget.postId);
  }

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
            liked
                ? profileController.saveLike(profile, widget.postId)
                : profileController.removeLike(profile, widget.postId);
          },
          icon: liked
              ? Assets.icons.like
                  .image(height: 30, width: 30, color: DesignhubColors.primary)
              : Assets.icons.like.image(height: 30, width: 30)),
    );
  }
}
