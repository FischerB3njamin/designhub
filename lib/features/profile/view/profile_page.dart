import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/features/follow/widgets/section_follow.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/provider/profile_notifier.dart';
import 'package:designhub/features/profile/widgets/btn_sg_profile_sections.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _hasRequestedEdit = true;

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileNotifier>();
    final currentProfileNotifier = context.watch<CurrentProfileNotifier>();

    if (currentProfileNotifier.isChanged) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        profileProvider.update(currentProfileNotifier.getProfile());
      });
    }

    if (currentProfileNotifier.getProfile().name.isEmpty && _hasRequestedEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        profileProvider.showEdit(context);
      });
      setState(() => _hasRequestedEdit = false);
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            _buildHeader(context, profileProvider.innerProfile),
            _buildName(context),
            const SizedBox(height: 16),
            SectionFollow(profile: profileProvider.innerProfile),
            const SizedBox(height: 16),
            BtnSgProfileSections(
              selectedTab: profileProvider.selectedTab,
              profileId: profileProvider.innerProfile.userId,
            ),
            const SizedBox(height: 16),
            profileProvider.pages[profileProvider.selectedTab],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Profile profile) {
    final hasValidImage = profile.backgroundImagePath.isNotEmpty;

    return SizedBox(
      height: 275,
      width: double.infinity,
      child: Stack(
        children: [
          hasValidImage
              ? CachedNetworkImage(
                  imageUrl: profile.backgroundImagePath,
                  placeholder: (context, url) => Container(
                    color: DesignhubColors.white,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 180,
                  width: double.infinity,
                  color: DesignhubColors.grey300,
                  alignment: Alignment.center,
                  child: Icon(Icons.image,
                      size: 40, color: DesignhubColors.grey700),
                ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 53.0),
              child: AvatarCircle(
                profile: profile,
                height: 200,
                width: 200,
                allowNavigation: false,
              ),
            ),
          ),
          _buildEditButton(context),
        ],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    final profileNotifier = context.watch<ProfileNotifier>();
    return Positioned(
      right: 8,
      top: 8,
      child: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => profileNotifier.showEdit(context),
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    final profileNotifier = context.watch<ProfileNotifier>();

    return Text(
      profileNotifier.innerProfile.name,
      style: TextTheme.of(context)
          .headlineMedium!
          .copyWith(fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }
}
