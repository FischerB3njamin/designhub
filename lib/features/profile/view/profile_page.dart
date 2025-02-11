import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/widgets/btn_sg_profile_sections.dart';
import 'package:designhub/features/profile/widgets/profile_info.dart';
import 'package:designhub/features/profile/widgets/profile_saved.dart';
import 'package:designhub/features/profile/widgets/profile_work.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;

  const ProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Set<String> tabBar = {"Work", "Info", "Saved"};
  String selectedTab = "Info";

  @override
  Widget build(BuildContext context) {
    Map pages = {
      'Work': ProfileWork(
        profile: widget.profile,
      ),
      'Info': ProfileInfo(
        profile: widget.profile,
      ),
      'Saved': ProfileSaved(
        profile: widget.profile,
      )
    };

    return ListView(
      children: [
        SizedBox(
          height: 275,
          width: double.infinity,
          child: Stack(
            children: [
              Image.network(
                widget.profile.backgroundImagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 53.0),
                  child: AvatarCircle(
                    imagePath: widget.profile.avatarImagePath,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          widget.profile.name,
          style: TextTheme.of(context)
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        BtnSgProfileSections(
          callback: (value) => setState(() {
            if (value.isNotEmpty) selectedTab = value.first;
          }),
          selectedTab: selectedTab,
          profileId: widget.profile.userId,
        ),
        SizedBox(height: 16),
        pages[selectedTab]
      ],
    );
  }
}
