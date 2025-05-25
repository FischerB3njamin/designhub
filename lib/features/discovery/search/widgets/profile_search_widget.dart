import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/socials/profile/provider/profile_notifier.dart';
import 'package:designhub/features/socials/profile/view/profile_page.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSearchWidget extends StatelessWidget {
  final Profile profile;

  const ProfileSearchWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProfileNotifier>().init(profile);
        CustomBottomSheet.show(context, ProfilePage(), 0.9);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: DesignhubColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: DesignhubColors.black.withAlpha(50),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding:
                const EdgeInsets.only(top: 50, bottom: 20, left: 16, right: 16),
            child: Text(
              profile.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: CustomTextStyles.titleMediumBold(context, FontWeight.bold),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: AvatarCircle(
                profile: profile,
                height: 80,
                width: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
