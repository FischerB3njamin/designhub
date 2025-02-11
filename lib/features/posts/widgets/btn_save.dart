import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class BtnSave extends StatefulWidget {
  final String postId;

  const BtnSave({
    super.key,
    required this.postId,
  });

  @override
  State<BtnSave> createState() => _BtnSaveState();
}

class _BtnSaveState extends State<BtnSave> {
  late bool saved =
      ProfileSingleton().profile!.savedPosts.contains(widget.postId);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: IconButton(
        key: ValueKey<bool>(saved),
        onPressed: () {
          setState(() {
            saved = !saved;
          });
        },
        icon: saved
            ? Assets.icons.folder.svg(
                height: 35,
                width: 35,
              )
            : Assets.icons.folder.svg(
                height: 35,
                width: 35,
                colorFilter: ColorFilter.mode(
                  DesignhubColors.primary,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
}
