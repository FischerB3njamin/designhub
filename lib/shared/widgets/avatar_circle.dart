import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/view/profile_external_page.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  final Profile profile;
  final double width;
  final double height;
  final bool allowNavigation;

  const AvatarCircle({
    super.key,
    required this.profile,
    required this.height,
    required this.width,
    this.allowNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (allowNavigation) {
          CustomBottomSheet.show(
              context,
              ProfileExternalPage(
                profile: profile,
              ),
              0.9);
        }
      },
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: CachedNetworkImage(
          imageUrl: profile.avatarImagePath,
          placeholder: (context, url) => Container(
            color: DesignhubColors.white,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
