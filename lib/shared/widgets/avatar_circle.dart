import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/view/profile_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/controller/controller.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  const AvatarCircle(
      {super.key,
      required this.profilId,
      required this.height,
      required this.width,
      this.allowNavigation = true});

  final String profilId;
  final double width;
  final double height;
  final bool allowNavigation;

  @override
  Widget build(BuildContext context) {
    Profile profile = Controller().profileDB.getProfile(profilId);
    return GestureDetector(
      onTap: () => allowNavigation
          ? CustomBottomSheet.show(context, ProfilePage(profile: profile), 0.9)
          : () {},
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Image.network(
          profile.avatarImagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Assets.images.noImage.image(
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
