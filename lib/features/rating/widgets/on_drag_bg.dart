import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class OnDragBg extends StatelessWidget {
  const OnDragBg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Assets.icons.like.image(
          width: 100,
          height: 100,
          color: DesignhubColors.primary,
        ),
        Spacer(),
        Assets.icons.dislike.image(
          width: 100,
          height: 100,
          color: DesignhubColors.primary,
        ),
      ],
    );
  }
}
