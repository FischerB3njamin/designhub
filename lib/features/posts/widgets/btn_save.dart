import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BtnSave extends StatelessWidget {
  final String postId;

  const BtnSave({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    final currentProfileNotifier = context.watch<CurrentProfileNotifier>();
    bool saved = currentProfileNotifier.getSavedPost(postId);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: IconButton(
        key: ValueKey<bool>(saved),
        onPressed: () => currentProfileNotifier.toggleSavePost(postId),
        icon: saved
            ? Assets.icons.folder.svg(
                height: 35,
                width: 35,
                colorFilter:
                    ColorFilter.mode(DesignhubColors.primary, BlendMode.srcIn),
              )
            : Assets.icons.folder.svg(height: 35, width: 35),
      ),
    );
  }
}
